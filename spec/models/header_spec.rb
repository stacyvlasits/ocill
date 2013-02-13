require 'spec_helper'

describe Header do
  it "should have valid factory" do
    FactoryGirl.build(:header).should be_valid
  end

  it "should require a drill" do
    FactoryGirl.build(:drillless_header).should_not be_valid
  end

  describe "saved" do
    it "should have a position" do
      header = FactoryGirl.create(:header)
      header.position.should_not be_nil
    end
    describe "with several siblings" do
      it "should have different positions" do
        header = FactoryGirl.create(:five_siblinged_header)
        siblings = header.drill.headers
        sibling_positions = siblings.map {|h| h.position}
        siblings.size.should == sibling_positions.uniq.size
      end
    end
  end

end
