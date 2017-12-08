RSpec.describe C do
  
  context 'the c shortcut in global namespace' do 
    it 'exists' do
      expect( c ).to be_kind_of(C)
    end
  end
end
