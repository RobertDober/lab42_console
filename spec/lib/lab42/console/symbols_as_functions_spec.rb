RSpec.describe C do
  describe 'symbols' do

    context 'as functions' do 
      context 'w/o block' do 
        it 'does what it says' do
          expect( c.fn(:succ).(41) ).to eq( 42 )
        end

        it 'parameters are **not** a problem' do
          expect( c.fn(:-, 1).(43) ).to eq( 42 )
        end
      end

      context 'with block' do 
        it { expect( c.fn(:succ){|x| x * 2}.(20)).to eq(42) }
      end
    end

    context 'as partials' do 
      context 'w/o block' do
        it { expect( c.p(1..2, :include?).(2) ).to be_truthy }
        it { expect( c.p(1..2, :include?).(3) ).to be_falsy }
      end

      context 'with block' do 
        it { expect( c.p(%w{a}, :size, &:succ).() ).to eq( 2 ) }
      end
    end
  end
end
