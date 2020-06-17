module Lab42
  class Console
    class Function
      Error = Class.new RuntimeError

      attr_reader :functions

      def add(*args, &blk)
        if args.empty?
          _add_blk(blk)
        else
          raise Error, "must not provide literal and block behaviour at the same time" if blk
          _add_args(args)
        end
        self
      end

      def call(element)
        functions
          .inject(element) do |acc, fn| 
            fn.(acc) 
          end
      end

      def to_proc
        -> x { call(x) }
      end

      private

      def initialize(*args, &blk)
        @functions = []
        add(*args, &blk)
      end

      def _add_args(args)
        functions << _add_args_fn(args)
      end

      def _add_args_fn(args)
        -> reciever do
          reciever.send(*args)
        rescue
          nil
        end
      end

      def _add_blk(blk)
        functions << blk
      end

    end
  end
end
