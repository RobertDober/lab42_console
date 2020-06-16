module Lab42
  class Console
    class Runner

      attr_reader :filter, :method, :subject

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

      def initialize(*args, by: [], method:, subject:)
        @args    = args
        @by      = by
        @id      = args.first
        @method  = method
        @subject = subject
        @filter  = _default_filter
        _init_by(by) unless by.empty?
      end

      def _default_filter
        -> element do
          element.id == @id
        rescue
          nil
        end
      end

      def _init_by(by)
        @args = by
      end

      def _make_filter(*args)
        if args.size == 1
          -> element do
            element.send(*@args) == args.first
          end
        else
          -> element do
            element.send(*@args).send(*args)
          end
        end
      end
    end
  end
end
