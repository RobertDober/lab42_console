require_relative './tools.rb'
module Lab42
  class Console
    module Fn
      def fn desc, *args, &blk
        case desc
        when Symbol,  String
          Tools.make_fn [desc, *args], blk
        else
          raise ArgumentError, "#{desc} does not describe a function"
        end
      end

      def p rcv, name, *args, &blk
        m = rcv.method(name)
        Tools.make_partial m, args, blk
      end
    end
    include Fn
  end
end
