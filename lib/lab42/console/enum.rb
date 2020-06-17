require_relative 'wrapper'
module Lab42
  class Console
    module Enum
      def by(*args, &blk)
        Lab42::Console::Wrapper.new(self, args, &blk)
      end
    end
  end
end
