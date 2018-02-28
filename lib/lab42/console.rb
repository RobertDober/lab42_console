require_relative 'console/h'
require_relative 'console/intrusive'
require_relative 'console/fn'
require_relative 'console/kwd'
require_relative 'console/shortcut'

require_relative 'lazy'

module Lab42
  class Console
    def kwd; Kwd end
    def h; H end
  end
end

class Object
  include Lab42::Console::Shortcut
end
