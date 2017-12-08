require_relative 'tools/forward_to_new_instance'

module Lab42
  class Console
    class Kwd
      attr_reader :kwds

      
      extend Tools::ForwardToNewInstance
      
      def count key
        kwds.count{ |pairs| key  == pairs.keys.first }
      end


      def first_value *keys
        raise ArgumentError, "need 0, 1, got #{keys.size}" unless keys.size < 2
        key = keys.first
        if key
          kwds.find{ |pairs| pairs.keys.first == key }.values.first
        else
          kwds.first.values.first
        end
      end

      def last_value *keys
        raise ArgumentError, "need 0, 1, got #{keys.size}" unless keys.size < 2
        key = keys.first
        if key
          kwds.reverse.find{ |pairs| pairs.keys.first == key }.values.first
        else
          kwds.reverse.first.values.first
        end
      end

      def values *keys
        keys = keys.flatten
        if keys.empty?
          kwds.map{ |pairs| pairs.values.first }
        else
          kwds.map{ |pairs| keys.include?(pairs.keys.first) && pairs.values.first }.select(&:identity)
        end
      end


      private

      def initialize kwds 
        @kwds = kwds
      end
    end
  end
end
