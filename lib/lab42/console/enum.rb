require_relative 'runner'
module Lab42
  class Console
    module Enum
      def by(*args)
        Lab42::Console::Runner.new(by: args, method: nil, subject: self)
      end
      def fnd(*args)
        if args.size.zero?
          Lab42::Console::Runner.new(method: :find, subject: self)
        else
          Lab42::Console::Runner.new(*args, method: :find, subject: self).run
        end
      end
      def sel(*args)
        if args.size.zero?
          Lab42::Console::Runner.new(method: :filter, subject: self)
        else
          Lab42::Console::Runner.new(*args, method: :filter, subject: self).run
        end
      end
    end
  end
end
