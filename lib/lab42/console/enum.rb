require_relative 'cons'
require_relative 'wrapper'
module Lab42
  class Console
    module Enum
      def by(*args, &blk)
        Lab42::Console::Wrapper.new(self, *args, &blk)
      end

      def cars
        map(&:car)
      end

      def cdrs
        map(&:cdr)
      end

      def duplicate
        map{ |x| Cons.new(x, x) }
      end

    end
  end
end
