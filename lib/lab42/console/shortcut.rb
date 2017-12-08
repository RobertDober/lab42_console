module Lab42
  class Console
    module Shortcut
      def c
        @__lab42_console_shortcut__ ||=  Lab42::Console.new
      end
    end
  end
end
