require 'spec_helper'
describe Drill do

  describe '.children' do
    it "lists the exercises that belong to the drill" do
      drill = FactoryGirl.create(:drill_with_exercises)
      drill.children.should be == drill.exercises
    end
  end

  describe '.parent' do
    it "returns the lesson to which the drill belongs" do
      drill = FactoryGirl.create(:drill)
      drill.parent.should be == drill.lesson
    end
  end

  describe '.set_default_values' do
    it "adds a default position" do
      drill = FactoryGirl.create(:drill)
      drill.position.should_not be_nil
    end

    it "adds a default header_row" do
      drill = FactoryGirl.create(:drill)
      drill.header_row.should_not be_empty
    end

    it "adds a default title" do
      drill = FactoryGirl.build(:drill_with_no_title)
      drill.send(:set_default_values)
      drill.title.should_not be_empty
    end
  end


  describe '.rows' do
    it "tells how many elements are in the header_row" do
      drill = FactoryGirl.create(:drill)
      drill.rows.should == drill.exercises.size
    end
  end

end
