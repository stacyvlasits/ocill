require File.dirname(__FILE__) + '/../spec_helper'

describe ExerciseItem do
  describe ".set_default_type" do
    it "doesn't get set when the exericise item hasn't been saved" do
      exercise_item = FactoryGirl.build(:exercise_item)
      exercise_item.type.should be_nil
    end
    it "assigns a default type when the exercise item is saved" do
<<<<<<< HEAD
      exercise_item = FactoryGirl.create(:exercise_item)
      exercise_item.type.should_not be_nil    
=======
      # exercise_item = FactoryGirl.create(:exercise_item)
      # exercise_item.type.should_not be_nil    
      pending('not sure this test is necessary/desireable')
>>>>>>> experiments
    end
    it "should not set a type if one is already set" do
      exercise_item = FactoryGirl.build(:typed_exercise_item)
      previously_defined_type = exercise_item.type
      exercise_item.save
      exercise_item.type.should == previously_defined_type
    end 
  end

<<<<<<< HEAD
  describe ".set_default_header" do
    # it "should not set a header if the header is already set" do
    #   exercise_item = FactoryGirl.build(:headered_exercise_item)
    #   previously_defined_header = exercise_item.header
    #   exercise_item.save
    #   exercise_item.header.should == previously_defined_header      
    # end
    # it "should update the drill so that it has one header for each new exercise_item" do
    #   exercise_item = FactoryGirl.create(:five_headered_siblinged_headered_exercise_item)
    #   drill = exercise_item.drill
    #   drill.headers.size.should == drill.exercise_items.size
    # end
  end

=======
>>>>>>> experiments
  describe ".siblings" do
    it "retrieves all of the exercise_item's siblings" do
      exercise_item = FactoryGirl.create(:five_siblinged_exercise_item)
      exercise_item.siblings.should be == exercise_item.parent.children            
    end

    it "does not include the exercise_item" do
      exercise_item = FactoryGirl.create(:five_siblinged_exercise_item)
      siblings = exercise_item.siblings
      siblings.should_not include(exercise_item)      
    end
  end

  describe ".header" do
    it "should be unique among the children of the same exercise" do
      exercise_item = FactoryGirl.create(:five_headered_siblinged_headered_exercise_item)
      sibling_headers = exercise_item.siblings.map {|e| e.header}
      sibling_headers.size.should be == sibling_headers.uniq.size
    end

    it "cannot have a duplicate value assigned to it" do
      exercise_item1 = FactoryGirl.create(:five_siblinged_headered_exercise_item)
      exercise_item2 = exercise_item1.siblings.first 
      expect {exercise_item1.header = exercise_item2.header}.to raise_error
    end
<<<<<<< HEAD

    # it "must match one of the values in its drill's collection of header" do
    #   exercise_item = FactoryGirl.create(:five_headered_siblinged_headered_exercise_item)
    #   header = exercise_item.header
    #   exercise_item.drill.headers.include?(header).should be_true
    # end
=======
>>>>>>> experiments
  end
end
