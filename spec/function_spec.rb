RSpec.describe Lab42::Console::Function do

  subject { described_class }
  let(:error) { subject::Error }


  describe "args -> send" do
    it "to its arg" do
      expect( subject.new(:+, 1).(41) ).to eq(42)
    end
    it "to_proc" do
      expect( (1..2).map(&subject.new(:succ)) ).to eq([2, 3])
    end
  end

  describe "block -> store" do
    it "and then call" do
      expect( subject.new{|x| x.succ}.(42) ).to eq(43)
    end
    it "to_proc" do
      expect( (3..4).map(&subject.new{|x| 10+x}) ).to eq([13, 14])
    end
  end

  describe "errors" do
    it "must not use args and a block" do
      expect{ subject.new(:succ){} }.to raise_error(error)
    end
  end
  
  describe "chaining" do
    it "can mix both forms" do
      expect( subject.new(:succ).add{ |x| x*2 }.(21) ).to eq(44)
    end
    it "yes it can" do
      expect( subject.new(:succ).add(:*, 2).add{ |x| x - 1 }.(22) ).to eq(45)
    end
  end
end
