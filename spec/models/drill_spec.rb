require 'spec_helper'
describe Drill do

  describe '.children' do
    it "lists the exercises that belong to the drill" do
      drill = FactoryGirl.create(:five_childed_drill)
      drill.children.should be == drill.exercises
    end
  end

  describe '.parent' do
    it "returns the unit to which the drill belongs" do
      drill = FactoryGirl.create(:drill)
      drill.parent.should be == drill.unit
    end
  end

  describe '.set_default_title' do
    it "adds a default title" do
      drill = FactoryGirl.build(:untitled_drill)
      drill.set_default_title
      drill.title.should_not be_blank
    end
  end

  describe '.rows' do
    it "tells how many elements are in the header_row" do
      drill = FactoryGirl.create(:drill)
      drill.rows.should == drill.exercises.size
    end
  end
end
