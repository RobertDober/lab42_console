RSpec.describe C do
  describe 'accessing nested hashes' do

    let( :tree ){{
      a: 42,
      b: %w{a b c},
      c: {
          ca: { caa: 100, cab: 200 },
          cb: "hello"
      },
      d: [{a: 1}, nil, %w{x y}]
    }}


    xit 'finds nodes' do
      # expect( c.h.find(tree, :a) ).to eq([42, 1])
      expect( c.h.new(tree).find(:a) ).to  eq([42, 1])
    end

    
  end
end
