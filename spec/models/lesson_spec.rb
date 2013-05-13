require 'spec_helper'
describe Lesson do
  describe ".children" do
    it "is the same as .drills when drills exist" do
      lesson_with_drills = FactoryGirl.create(:lesson_with_drills)
      expect(lesson_with_drills.children).to eq(lesson_with_drills.drills)
    end

    it "is the same as .drills when drills don't exist" do
      lesson = FactoryGirl.create(:lesson)
      expect(lesson.children).to eq(lesson.drills)
    end

    it "is empty when there are no drills" do
      lesson = FactoryGirl.create(:lesson)
      expect(lesson.children).to be_empty
    end
  end

  describe ".parent" do
    it "is the same as .course when course exists" do
      lesson = FactoryGirl.create(:lesson)
      expect(lesson.parent).to eq(lesson.course)
    end
  end
 end
