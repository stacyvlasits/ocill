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
    it "should evaluate correct responses as being correct" do
        exercise = FactoryGirl.create(:three_correct_responses_exercise)
        correct_responses = exercise.exercise_items.first.responses.all
        correct_responses.first.correct?.should be_true
        correct_responses.second.correct?.should be_true
        correct_responses.third.correct?.should be_true
    end

    it "should evaluate incorrect responses as being false" do
        exercise = FactoryGirl.create(:three_incorrect_responses_exercise)
        incorrect_responses = exercise.exercise_items.first.responses.all
        incorrect_responses.first.correct?.should be_false
        incorrect_responses.second.correct?.should be_false
        incorrect_responses.third.correct?.should be_false
    end
  end
end