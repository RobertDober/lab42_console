RSpec.describe C do
  describe 'keywords' do
    let( :unique ){ [{a: 42}, {b: 43}, {c: 44}] }
    let( :duplic ){ [{a: 42}, {b: 43}, {a: 44}] }

    context 'values' do 

      describe 'functional way' do
        it { expect( c.kwd.first_value(unique, :a) ).to eq(42) }
        it { expect( c.kwd.first_value(unique) ).to eq(42) }
        it { expect( c.kwd.first_value(unique, :b) ).to eq(43) }
        it { expect( c.kwd.first_value(duplic, :a) ).to eq(42) }
        it { expect( c.kwd.last_value(unique, :a) ).to eq(42) }
        it { expect( c.kwd.last_value(duplic, :a) ).to eq(44) }
        it { expect( c.kwd.values(unique, :a) ).to eq([42]) }
        it { expect( c.kwd.values(duplic, :a) ).to eq([42, 44]) }
        it { expect( c.kwd.count(unique, :a) ).to eq(1) }
        it { expect( c.kwd.count(duplic, :a) ).to eq(2) }
      end

      describe 'no keys' do
        it { expect( c.kwd.values(unique) ).to eq([42, 43, 44]) }
      end

      describe 'convenience wrapper' do
        let( :kwd ){ c.kwd.new(unique) }
        let( :kw2 ){ c.kwd.new(duplic) }

        it { expect( kwd.first_value(:a) ).to eq(42)  }
        it { expect( kwd.first_value(:b) ).to eq(43)  }
        it { expect( kwd.first_value() ).to eq(42)  }
        it { expect( kwd.last_value(:a) ).to eq(42)  }
        it { expect( kwd.values(:a) ).to eq([42])  }
        it { expect( kwd.count(:a) ).to eq(1)  }
        it { expect( kw2.first_value(:a) ).to eq(42)  }
        it { expect( kw2.last_value(:a) ).to eq(44)  }
        it { expect( kw2.values(:a) ).to eq([42, 44])  }
        it { expect( kw2.count(:a) ).to eq(2)  }

        it { expect( kwd.values ).to eq([42, 43, 44]) }
      end

      describe 'arguments' do
        it 'needs one or two' do
          expect{ c.kwd.values() }.to raise_error(ArgumentError)
          expect{ c.kwd.values(unique, :a, :b) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
