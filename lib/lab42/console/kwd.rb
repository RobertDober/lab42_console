module Lab42
  class Console
    class Kwd
      attr_reader :kwds
      
      class << self
        def method_missing name, kwds, *args
          insm = instance_method(name)
          insm.bind(new(kwds)).(*args)
        rescue NameError
          super
        end
      end

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
        raise ArgumentError, "need 0, 1, got #{keys.size}" unless keys.size < 2
        key = keys.first
        if key
          kwds.map{ |pairs| pairs.keys.first == key && pairs.values.first }.select(&:identity)
        else
          kwds.map{ |pairs| pairs.values.first }
        end
      end

      private

      def initialize kwds 
        @kwds = kwds
      end
    end
  end
end
