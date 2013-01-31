require File.dirname(__FILE__) + '/../spec_helper'

describe ExerciseItem do
  describe ".set_default_type" do
    it "doesn't get set when the exericise item hasn't been saved" do
      exercise_item = FactoryGirl.build(:exercise_item)
      exercise_item.type.should be_nil
    end
    it "assigns a default type when the exercise item is saved" do
      exercise_item = FactoryGirl.create(:exercise_item)
      exercise_item.type.should_not be_nil    
    end
    it "should not set a type if one is already set" do
      exercise_item = FactoryGirl.build(:exercise_item_with_type_defined)
      previously_defined_type = exercise_item.type
      exercise_item.save
      exercise_item.type.should == previously_defined_type
    end 
  end

  describe ".set_default_column" do
    it "should not set a column if the column is already set" do
      exercise_item = FactoryGirl.build(:exercise_item_with_column_defined)
      previously_defined_column = exercise_item.column
      exercise_item.save
      exercise_item.column.should == previously_defined_column      
    end
  end

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
      exercise_item = FactoryGirl.create(:exercise_item_with_five_siblings)
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
