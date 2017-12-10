require_relative 'tools/forward_to_new_instance'
module Lab42
  class Console
    class H
      extend Tools::ForwardToNewInstance

      attr_reader :hash

      def find *keys
        prewalk hash 
      end

      def pre_walk nodes, condition, visitor, visited: Set.new
        return if visisted.includes? nodes
        case nodes
        when Hash
          walk_hash_pairs nodes, condition, visitor, visited: visited
        when Enumerable
          nodes.each do |ele|
            pre_walk ele, condition, visitor, visited: visited.add(ele)
          end
        end
      end

      private

      def initialize hash 
        @hash = hash
      end


      def walk_hash_pairs nodes, condition, visitor, visited:
      end
    end
  end
end
