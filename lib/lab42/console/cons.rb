module Lab42
  class Console
    class Cons

      attr_reader :car, :cdr

      def apply_to_cdr(fun)
        self.class.new(car, fun.(cdr))
      end

      private

      def initialize(car, cdr)
        @car = car
        @cdr = cdr
      end
    end
  end
end
