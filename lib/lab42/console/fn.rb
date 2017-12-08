module Lab42
  class Console
    module Fn
      def fn desc, *args
        case desc
        when Symbol,  String
          -> (rcv, *a) {
            rcv.send(desc, *(args + a))
          }
        else
          raise ArgumentError, "#{desc} does not describe a function"
        end
      end
    end
    include Fn
  end
end
