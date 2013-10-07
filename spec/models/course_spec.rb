require 'spec_helper'
describe Course do
  describe ".children" do

    it "is the same as .units when units exist" do
      course_with_units = FactoryGirl.create(:course_with_units)
      expect(course_with_units.children).to eq(course_with_units.units)
    end

    it "is the same as .units when units don't exist" do
      course = FactoryGirl.create(:course)
      expect(course.children).to eq(course.units)
    end

    it "is empty when there are no units" do
      course = FactoryGirl.create(:course)
      expect(course.children).to be_empty
    end
  end
end