module Lab42
  class Console
    module Tools extend self
      def make_fn fn_ary, blk

        return ->(x){x} if fn_ary.empty? && blk.nil?
        return blk if fn_ary.empty?

        make_fn_from_ary( *fn_ary ).tap do | argfn |
          # Chain in one pass if applicable
          return ->(x){ blk.(argfn.(x)) } if blk
        end
      end

      def make_fn_from_ary desc, *args
        -> (rcv, *a) {
          rcv.send(desc, *(args + a))
        }
      end
    end
  end
end
