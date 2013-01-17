require File.dirname(__FILE__) + '/../spec_helper'

describe ExerciseItem do
  describe ".siblings" do
    it "retrieves all of the exercise_item's siblings" do
      exercise_item = FactoryGirl.create(:exercise_item_with_five_siblings)
      exercise_item.siblings.should be == exercise_item.parent.children            
    end

    it "does not include the exercise_item" do
      exercise_item = FactoryGirl.create(:exercise_item_with_five_siblings)
      siblings = exercise_item.siblings
      siblings.should_not include(exercise_item)      
    end
  end

  describe ".column" do
    it "should be unique among the children of the same exercise" do
      exercise_item = FactoryGirl.create(:exercise_item_with_five_siblings)
      siblings_columns = exercise_item.siblings.map {|e| e.column}
      siblings_columns.size.should be == siblings_columns.uniq.size
    end

    it "cannot have a duplicate value assigned to it" do
      exercise_item1 = FactoryGirl.create(:exercise_item_with_five_siblings)
      exercise_item2 = exercise_item1.siblings.first 
      expect {exercise_item1.column = exercise_item2.column}.to raise_error
    end

    it "must match one of the values in its drill's header_row" do
      exercise_item = FactoryGirl.create(:exercise_item)
      header_row = exercise_item.drill.header_row
      header_row.include?(exercise_item.column).should be_true
    end
  end
  describe ".content" do
    it "should raise an error" do
      exercise_item = FactoryGirl.create(:exercise_item)  
      expect {exercise_item.content}.to raise_error(StandardError)
    end
  end

end
