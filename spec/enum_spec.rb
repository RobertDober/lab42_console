RSpec.describe Enumerable do
  let(:data) { (0..19).map{ |x| OpenStruct.new(id: x % 10, name: "#{x}") } }

  describe "simple comparer" do
    it "finds something" do
      expect( data.by(:id).fnd(1) ).to eq(OpenStruct.new(id: 1, name: "1"))
    end
    it "finds nothing" do
      expect( data.by(:id).fnd(11) ).to be_nil
    end
    it "tolerates method missing" do
      expect( data.by(:xxx).fnd(11) ).to be_nil
    end
    it "selects something" do
      expect( data.by(:id).sel(1) ).to eq([OpenStruct.new(id: 1, name: "1"), OpenStruct.new(id: 1, name: "11")])
    end
    it "selects nothing" do
      expect( data.by(:id).sel(11) ).to be_empty
    end
    it "method missing is falsy" do
      expect( data.by(:xxx).sel(11) ).to be_empty
    end
  end

  describe "by" do
    it "finds by name" do
      expect( data.by(:name).fnd("11") ).to eq(OpenStruct.new(id: 1, name: "11"))
    end
    it "finds by key access" do
      expect( data.by(:[], :name).fnd(:==, "11") ).to eq(OpenStruct.new(id: 1, name: "11"))
    end
    it "selects by name" do
      expect( data.by(:name).sel("11") ).to eq([OpenStruct.new(id: 1, name: "11")])
    end
    it "selects by comparison" do
      expect( data.by(:id).sel(:>, 8) ).to eq([OpenStruct.new(id: 9, name: "9"), OpenStruct.new(id: 9, name: "19")])
    end
    it "selects by matched key access" do
      expect( data.by(:[], :name).sel(:=~, %r{9\z}) ).to eq([OpenStruct.new(id: 9, name: "9"), OpenStruct.new(id: 9, name: "19")])
    end
  end

  
end
