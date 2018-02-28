require_relative 'tools/forward_to_new_instance'
module Lab42
  class Console
    class H

      extend Tools::ForwardToNewInstance

      attr_reader :hash

      def access *keys
        keys.inject( hash ) do | subhash, key |
          subhash.fetch(key)
        end
      end

      def find *keys
        pre_walk hash, key_is_included(*keys), [] 
      end

      def pre_walk nodes, condition, visitor, visited: Set.new
        return if visited.include? nodes
        case nodes
        when Hash
          walk_hash_pairs nodes, condition, visitor, visited: visited.add(nodes)
        when Enumerable
          walk_enum nodes, condition, visitor, visited: visited.add(nodes)
        else
          process_elem nodes, condition, visitor
        end
        visitor
      end

      def update keys, value
        self.class.new(_update(keys, value))
      end

      private

      def initialize hash 
        raise ArgumentError, "#{hash.inspect} is not a Hash" unless Hash === hash
        @hash = hash
      end


      # Walking
      # -------

      # Running down and keeping track
      # input                              | keys      | output ^current :current_key
      # -----------------------------------+-----------+-------------------------------------
      # { a: { b: {x: 1, y: 2} }, b: ... } | %i[a b x] | ^{ a: nil, b: ... }, :a
      #      { b: {x: 1, y: 2} }           | %i[b x]   | {a: ^{ b: nil }, b: ...}, :b
      #           {x: 1, y: 2}             | %i[x]     | {a: { b: ^{x: nil, y: 2} }, b: ...}, :x
      #           ----                     |   []      [        ^.merge!(x: value)
      def _update keys, value
        result = keys.inject([[]]) do | hashes, current_key |
          shared_copy = (hashes.last.last || hash).dup_key(current_key)
          hashes << [shared_copy, shared_copy[current_key]]
        end
        # [:c, [{:c=>1, :d=>2}, 1]],
        # [:b, [{:b=>{:c=>1, :d=>2}}, {:c=>1, :d=>2}]],
        # [:a, [{:a=>{:b=>{:c=>1, :d=>2}}}, {:b=>{:c=>1, :d=>2}}]]]
        keys.zip(result.drop 1).reverse.inject value do | val, (key, (parent, _) ) |
          parent.update( key => val )
        end
      end

      def process_elem node, condition, visitor
        return unless condition.(node)
        visitor << node
      end

      def process_hash_pair pair, condition, visitor
        return unless condition.(pair)
        visitor << pair.last
      end

      def walk_enum nodes, condition, visitor, visited:
        nodes.each do |ele|
          pre_walk ele, condition, visitor, visited: visited
        end
      end

      def walk_hash_pairs pairs, condition, visitor, visited:
        pairs.each do | pair |
          process_hash_pair pair, condition, visitor
          pre_walk pair.last, condition, visitor, visited: visited
        end
      end

      # Functors
      # --------
      def key_is_included *keys
        -> (pair_or_ele) {
          return false unless Array === pair_or_ele
          keys.include? pair_or_ele.first
        }
      end

      # Helpers
      # -------
      def make_acc input, parent, current
         OpenStruct.new(input: input, parent: parent, current: current)
      end
    end
  end
end
