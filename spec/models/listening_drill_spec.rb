require File.dirname(__FILE__) + '/../spec_helper'

describe ListeningDrill do
  describe ".create" do
    it "should create and save a ListeningDrill" do
      listening_drill = FactoryGirl.create(:listening_drill)
      listening_drill.new_record?.should be_false
    end
  end
end