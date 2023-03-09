require 'cocoapods'
require 'cocoapods-entangle/podfile_entangle'
module Pod
  class Specification
      attr_accessor :entangle_dependencies

      def entangle_dependency(pod, *requirements)
        store_entangle_dependency(pod, *requirements)
      end

      def store_entangle_dependency(pod, *requirements)
        hash = Hash.new
        hash[pod] = requirements
        self.entangle_dependencies ||= {}
        self.entangle_dependencies[pod] = requirements
      end

      # get all entangle dependencies
      # @return [Dependency]
      def entangle_dependencys
        return [] unless self.entangle_dependencies.empty?
        dependencys = []
        self.entangle_dependencies.each do |name, requirements|
          dependencys << Pod::Dependency.new(name, requirements)
        end
        dependencies
      end
  end
end
