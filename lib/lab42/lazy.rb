module Lab42
  class Lazy < Enumerator::Lazy

    def f *a, &blk
      return force if a.empty? && blk.nil?
      super
    end

    old_inspect = instance_method(:inspect)
    define_method :inspect1 do
      old_inspect.bind(self).()
    end

    def inspect
      force
    end

  end
end
