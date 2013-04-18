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
<<<<<<< HEAD

  describe ".set_default_values" do 

    it "doesn't change the value of .position if .position is already set" do
      course = FactoryGirl.create(:course)
      position = course.position
      expect(course.send(:set_default_values)).to eq(position)
    end

    it "sets .position to a number if it isn't one already" do
      course = FactoryGirl.create(:course)      
      course.position = nil
      course.send(:set_default_values).should be_an_instance_of(Fixnum)
    end

    
  end

=======
>>>>>>> experiments
end