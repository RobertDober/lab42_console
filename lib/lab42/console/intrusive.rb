require_relative './tools'
# This is the reason not to use this in the console!!!

class Object
  def identity; self end
end

module Enumerable
  def m *args, &blk
    blk = Lab42::Console::Tools.make_fn(args, blk)
    Enumerator::Lazy.new(self) do | yielder, element |
      yielder << ( blk ? blk.(element) : element )
    end
  end

  def fm *args, &blk
    blk = Lab42::Console::Tools.make_fn(args, blk)
    Enumerator::Lazy.new(self) do | yielder, element |
      producer = Array(blk ? blk.(element) : element)
      producer.lazy.each do |ele|
        yielder << ele
      end
    end

  end
end

class Enumerator::Lazy
  alias_method :f, :force
end
