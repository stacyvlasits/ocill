require File.dirname(__FILE__) + '/../spec_helper'

describe Exercise do
  describe  "validations" do
    it "prevents the creation of an instance without a prompt" do
      exercise = FactoryGirl.build(:exercise)
      exercise.prompt=nil
      exercise.valid?.should be_false  
    end
  end

  describe ".parent" do
    it "is an alias for drill" do
      exercise = FactoryGirl.create(:exercise)
      exercise.parent.should be == exercise.drill
    end
  end

  describe ".children" do
    it "is an alias for exercise_items" do
      exercise = FactoryGirl.create(:five_childed_exercise)
      exercise.children.should be == exercise.exercise_items
    end
  end

  describe ".lesson" do
    it "should return the lesson the exercise is part of" do
      exercise = FactoryGirl.create(:exercise)
      exercise.lesson.should be == exercise.drill.lesson
    end
  end
end