module Lab42
  class Console
    module Tools extend self
      module ForwardToNewInstance
        def method_missing name, kwds, *args
          insm = instance_method(name)
          insm.bind(new(kwds)).(*args)
        rescue NameError
          super
        end
      end
    end
  end
end
