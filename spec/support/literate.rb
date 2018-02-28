module Literate

  def doctest file
    # file = File.join(PROJECT_ROOT, file)
    # content = File.readlines(file)
    # it{ expect( true ).to  be_truthy }
  end

end

RSpec.configure do | conf |
  conf.extend Literate
end
