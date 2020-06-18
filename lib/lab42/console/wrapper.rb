require_relative 'function'
module Lab42
  class Console
    class Wrapper

      attr_reader :function, :subject

      def add(*args, &blk)
        @function = function.add(*args, &blk)
        self
      end


      def fnd(*args, &blk)
        _apply_function
          .find{ |x| x.apply_to_cdr(_make_function(*args, &blk))&.cdr }
          &.car
      end

      def sel(*args, &blk)
        filter_function = _make_function(*args, &blk)
        _apply_function
          .filter{ |x| x.apply_to_cdr(filter_function)&.cdr }
          .map(&:car)
      end


      private

      def initialize(subject, *args, &blk)
        _init_function(args, blk)
        @subject = subject
      end

      def _apply_function
        subject
          .duplicate
          .map{ |x| x.apply_to_cdr(function) }
      end

      def _init_function(args, blk)
        @function = Function.new(*args, &blk) 
      end

      def _make_function(*args, &blk)
        case args.first
        when Symbol
          Function.new(*args, &blk)
        when NilClass
          Function.new([], &blk)
        else
          Function.new(*([:==]+args), &blk)
        end
      end
    end
  end
end
