module Lab42
  class Functor < BasicObject

    attr_reader :function, :result


    def call *args
      @result = function.(*args)
    end

    def inspect
      result.to_s
    end

    private

    def initialize &function
      @function = function
      @result   = nil
    end

  end
end
