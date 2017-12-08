require_relative './tools.rb'
module Lab42
  class Console
    module Fn
      def fn desc, *args
        case desc
        when Symbol,  String
          Tools.make_fn_from_ary desc, *args
        else
          raise ArgumentError, "#{desc} does not describe a function"
        end
      end
    end
    include Fn
  end
end
