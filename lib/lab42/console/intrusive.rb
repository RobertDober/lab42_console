require_relative './tools'

# This is the reason not to use this anywhere else but in  the console!!!
# =======================================================================

class Object
  def identity; self end
end

module Enumerable
  
  def f *args, &blk
    blk = Lab42::Console::Tools.make_fn(args, blk)
    Lab42::Lazy.new(self) do | yielder, element |
      yielder << element if blk.(element) 
    end
  end

  def f! *args, &blk
    blk = Lab42::Console::Tools.make_fn(args, blk)
    Lab42::Lazy.new(self) do | yielder, element |
      yielder << element unless blk.(element) 
    end
  end

  def m *args, &blk
    blk = Lab42::Console::Tools.make_fn(args, blk)
    Lab42::Lazy.new(self) do | yielder, element |
      yielder << ( blk ? blk.(element) : element )
    end
  end

  def fm *args, &blk
    blk = Lab42::Console::Tools.make_fn(args, blk)
    Lab42::Lazy.new(self) do | yielder, element |
      producer = Array(blk ? blk.(element) : element)
      producer.lazy.each do |ele|
        yielder << ele
      end
    end

  end
end
