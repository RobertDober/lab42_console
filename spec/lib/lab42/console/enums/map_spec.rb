RSpec.describe C do
  describe 'enum' do

    context 'map behaves as necessary, and is shorter too: m' do

      context 'on arys' do
        it 'does not bother with empty' do
          expect( [].m ).to be_kind_of(Enumerator::Lazy)
          expect( [].m.f ).to be_empty
        end

        it 'lets us append things' do
          expect( %w{a b}.m(:+, 'x').f ).to eq(%w{ax bx})
        end

        it 'can be chained' do
          expect( %w{a b}.m(:+, 'x').m{ |y| "_#{y}" }.f ).to eq(%w{_ax _bx})
          expect( %w{a b}.m(:+, 'x'){ |y| "_#{y}" }.f ).to eq(%w{_ax _bx})
        end

        it 'we can use m whenever it suits us' do
          expect( %w{a b}.m.m(:+, 'x').m.f ).to eq(%w{ax bx})
        end
      end

    end

    context 'on hashes' do
      let( :values ){ {a: 42, b: 43, c: 44} }
      it{ expect( values.m ).to be_kind_of(Enumerator::Lazy) }
      it{ expect( values.m{|x,y| [y,x]}.f ).to eq([[42, :a], [43, :b], [44, :c]]) }
      it{ expect( values.fm{|x,y| [y,x]}.f ).to eq([42, :a, 43, :b, 44, :c]) }
    end

    context 'on ranges' do
      let( :digits ){ 0..9 }

      it{ expect( digits.m ).to be_kind_of(Enumerator::Lazy) }
      it{ expect( digits.m(:+, 1).m(:+, 1).f ).to eq([*2..11]) }
    end

  end
end
