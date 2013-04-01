require 'spec_helper'
describe Course do
  describe ".children" do

    it "is the same as .lessons when lessons exist" do
      course_with_lessons = FactoryGirl.create(:course_with_lessons)
      expect(course_with_lessons.children).to eq(course_with_lessons.lessons)
    end

    it "is the same as .lessons when lessons don't exist" do
      course = FactoryGirl.create(:course)    
      expect(course.children).to eq(course.lessons)
    end

    it "is empty when there are no lessons" do
      course = FactoryGirl.create(:course)
      expect(course.children).to be_empty
    end
  end
end