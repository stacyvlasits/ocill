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

  describe ".unit" do
    it "should return the unit the exercise is part of" do
      exercise = FactoryGirl.create(:exercise)
      exercise.unit.should be == exercise.drill.unit
    end
  end

  describe "Fill in the blank exercise" do
    it "should return the drill's exercises" do
        drill = FactoryGirl.create(:five_exercised_fill_drill)
        drill.children.should be == drill.exercises
    end
    it "should return the drill's exercise_items" do
        drill = FactoryGirl.create(:five_exercised_fill_drill)
        drill.children.each do |exercise|
          exercise.children.should be == drill.children.find(exercise.id).exercise_items
        end
    end
  end
end