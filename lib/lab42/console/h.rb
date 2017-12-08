module Lab42
  class Console
    class H
      attr_reader :hash

      def find *keys
        keys = Array(keys)
      end

      private

      def initialize hash 
        @hash = hash
      end
    end
  end
end
