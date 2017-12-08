RSpec.describe C do
  describe 'symbols' do
    context 'as functions' do 
      context 'with c' do 
        it 'does what it says' do
          expect( c.fn(:succ).(41) ).to eq( 42 )
        end

        it 'parameters are **not** a problem' do
          expect( c.fn(:-, 1).(43) ).to eq( 42 )
        end
      end
    end
  end
end
