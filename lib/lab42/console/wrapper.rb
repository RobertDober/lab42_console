require_relative 'function'
module Lab42
  class Console
    class Wrapper

      attr_reader :function, :subject

      def fnd(*args)
        @method = :find
        @filter = _make_filter(*args)
        run
      end

      def run
        subject
          .send(method, &filter)
      end

      def sel(*args)
        @method = :filter
        @filter = _make_filter(*args)
        run
      end


      private

      def initialize(subject, *args, &blk)
        _init_function(args, blk)
        @subject = subject
      end

      def _init_function(args, blk)
        @function = Function.new(*args, blk) 
      end
    end
  end
end
