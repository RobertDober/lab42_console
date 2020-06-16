# require_relative 'console/h'
# require_relative 'console/intrusive'
# require_relative 'console/fn'
# require_relative 'console/kwd'
# require_relative 'console/shortcut'

# require_relative 'lazy'

require_relative "console/enum"
module Enumerable
  extend Lab42::Console::Enum
end
class Array
  include Lab42::Console::Enum
end

# class Object
#   include Lab42::Console::Shortcut
# end
