require 'spec_helper'
describe Unit do
  describe ".children" do
    it "is the same as .drills when drills exist" do
      unit_with_drills = FactoryGirl.create(:unit_with_drills)
      expect(unit_with_drills.children).to eq(unit_with_drills.drills)
    end

    it "is the same as .drills when drills don't exist" do
      unit = FactoryGirl.create(:unit)
      expect(unit.children).to eq(unit.drills)
    end

    it "is empty when there are no drills" do
      unit = FactoryGirl.create(:unit)
      expect(unit.children).to be_empty
    end
  end

  describe ".parent" do
    it "is the same as .course when course exists" do
      unit = FactoryGirl.create(:unit)
      expect(unit.parent).to eq(unit.course)
    end
  end
 end
