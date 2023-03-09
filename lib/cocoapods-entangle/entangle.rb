module Pod
    class Entangle
        class << self
            public 
            
            def entangle_cache_dir
                @entangle_cache_dir ||= Pathname.new(entangle_my_home).join(".entangle_cache")
                @entangle_cache_dir.mkpath unless @entangle_cache_dir.exist?
                return @entangle_cache_dir.expand_path
            end
    
            def entangle_my_home
                @entangle_my_home ||= ENV["HOME"]
                @entangle_my_home ||= Pathname.new("~").expand_path
                return @entangle_my_home
            end
        end

    end
end