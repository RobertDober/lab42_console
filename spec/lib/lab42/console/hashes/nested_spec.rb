RSpec.describe C do
  describe "accessing nested hashes" do

    let( :tree ){{
      a: 42,
      b: %w{a b c},
      c: {
        ca: { caa: 100, cab: 200 },
        cb: "hello"
      },
      d: [{a: 1}, nil, %w{x y}]
    }}

    let( :htree ){ c.h.new(tree) }


    context "find nodes' values" do
      it "with scalar values" do
        expect( htree.find(:a) ).to  eq([42, 1])
      end

      it "with complex values" do
        expect( htree.find(:b) ).to  eq([%w{a b c}])
      end

      it "without looping" do
        tree.update(e: tree)
        expect( htree.find(:a) ).to  eq([42, 1])
      end
    end

    context "access a path" do
      it { expect( htree.access(:c, :ca) ).to eq({caa: 100, cab: 200}) }
    end

    context "updating nested keys" do
      let( :tree ){ { a: { b: {c: 1, d: 2}}} }
      let( :htree ){ c.h.new(tree) }

      it "copies the shared path" do
        ntree = htree.update(%i{a b c}, 42)
        expect( ntree.access(:a, :b, :c) ).to eq(42)
        expect( htree.access(:a, :b, :c) ).to eq(1)
      end
    end

  end
end
