RSpec.describe C do
  describe 'enum' do

    context 'filter' do

      context 'on ranges' do

        it "non regression w/o params it's a Lab42::Lazy " do
          expect( (1..3).lazy.f ).to be_kind_of(Lab42::Lazy)
        end
        it "... which shows as it's forced result" do
          expect( (1..3).lazy.f.inspect ).to eq([*1..3])
        end

        it "but with params it filters" do
          expect( (1..3).f(:odd?) ).to be_kind_of(Enumerator::Lazy)
          expect( (1..3).f(:odd?).f ).to eq([1, 3])
        end

        it 'can be chained' do
          expect( (1..3).f(:odd?).f(:<, 2).f ).to eq([1])
        end

        it 'can be negated' do
          expect( (1..3).f(:odd?).f!(:<, 2).f ).to eq([3])
        end

      end

    end
  end
end
