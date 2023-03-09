require 'cocoapods-entangle/entangle'
module Pod
    class SpecFetch
        def self.fetch_local_spec(path)
            pn = Pathname.new(path)
            real_spec_pn = pn + "#{pn.basename}.podspec"
            absolute_spec_pn = real_spec_pn.realpath
            return nil if !File.exist?(absolute_spec_pn)
            spec = Pod::Specification.from_file(absolute_spec_pn)
            deps = spec.entangle_dependencies
            deps
        end

        def self.fetch_specs(name, *requirements)
            clean_cache
            hash = requirements[0]
            ssh = hash[:git]
            branch = hash[:branch]
            raise "Could not find ssh" if ssh.nil? || ssh.empty?
            raise "Could not find branch" if branch.nil? || branch.empty?

            path = Entangle.entangle_cache_dir
            require 'cocoapods-sandbox'
            checker = Pod::Checkouter.new(ssh, branch, path).checkout
            return nil if checker.nil? || !checker

            current_pod_path = path + name
            return nil if current_pod_path.children.nil? || current_pod_path.children.empty?
            
            current_pod_path.children.each do |sub_path|
                ext = File.extname(sub_path.to_s)
                if ext == '.podspec'    
                    spec = Pod::Specification.from_file(sub_path)
                    return reslove_spec(spec) 
                end
            end
            nil
        end

        def self.reslove_spec(spec)
            deps = spec.entangle_dependencies
            clean_cache
            deps
        end

        def self.clean_cache
            cache_path = Entangle.entangle_cache_dir
            children = cache_path.children
            return if children.nil? || children.empty?
            children.each do |path| 
                FileUtils.rm_rf(path)
            end
        end
    end
end