require 'cocoapods-entangle/spec_fetch'
module Pod
  class Podfile
    # alias ori_pod pod
    # def pod(name = nil, *requirements)
    #   path = requirements[0][:path]
    #   if path != nil
    #     entangle_specs = SpecFetch.fetch_local_spec(path)
    #     if entangle_specs != nil && !entangle_specs.empty? 
    #       entangle_specs.each do |key, value|
    #         ori_pod(key, *value)
    #       end
    #     end
    #   end
    #   ori_pod(name, *requirements)
    # end
    
    def entangle_pod(name, *requirements)
      unless name
        raise StandardError, 'A dependency requires a name.'
      end

      pod(name, *requirements)
      entangle_specs = SpecFetch.fetch_specs(name, *requirements)
      return if entangle_specs == nil || entangle_specs.empty?

      entangle_specs.each do |key, value|
        pod(key, *value)
      end
    end
  end
end
