require 'lab42/console/version'
RSpec.describe C::VERSION do

  it 'is semantic' do
    expect( C::VERSION ).to match %r{\A \d+ \. \d+ \. \d+ \z}x
  end

end
