require 'spec_helper'
describe Drill do

  describe '.children' do
    it "lists the exercises that belong to the drill" do
      drill = FactoryGirl.create(:five_childed_drill)
      drill.children.should be == drill.exercises
    end
  end

  describe '.parent' do
    it "returns the lesson to which the drill belongs" do
      drill = FactoryGirl.create(:drill)
      drill.parent.should be == drill.lesson
    end
  end

<<<<<<< HEAD
  describe '.set_default_values' do
    it "adds a default position" do
      drill = FactoryGirl.create(:drill)
      drill.position.should_not be_nil
    end

    # it "adds a default header" do
    #   drill = FactoryGirl.create(:drill)
    #   drill.headers.size.should_not == 0
    # end

    it "adds a default title" do
      drill = FactoryGirl.build(:untitled_drill)
      drill.set_default_values
=======
  describe '.set_default_title' do
    it "adds a default title" do
      drill = FactoryGirl.build(:untitled_drill)
      drill.set_default_title
>>>>>>> experiments
      drill.title.should_not be_blank
    end
  end

<<<<<<< HEAD

=======
>>>>>>> experiments
  describe '.rows' do
    it "tells how many elements are in the header_row" do
      drill = FactoryGirl.create(:drill)
      drill.rows.should == drill.exercises.size
    end
  end
<<<<<<< HEAD

=======
>>>>>>> experiments
end
