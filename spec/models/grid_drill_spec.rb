require 'spec_helper'
describe GridDrill do

  describe '.add_column' do
    it "adds a header row if none exists" do
      drill = FactoryGirl.create(:drill)
      initial_header_row_size = drill.headers.size
      drill.add_column

      drill.headers.size.should be initial_header_row_size + 1
    end

    it "adds an additional header row to the current collection" do
      drill = FactoryGirl.create(:drill_with_headers)
      initial_header_row_size = drill.headers.size
      drill.add_column

      drill.headers.size.should be initial_header_row_size + 1
    end

    it "adds an exercise if none exist" do
      drill = FactoryGirl.create(:drill)
      before_exercises_size = drill.exercises.size
      drill.add_column("New Header")
      after_exercises_size = drill.exercises.size

      after_exercises_size.should == before_exercises_size + 1
    end
    
    it "adds an additional exercise_item to each child exercise" do
      drill = FactoryGirl.create(:drill_with_exercises)
      drill.add_column("New Header")
      drill.exercise_items.size.should == drill.exercises.size
    end

    describe 'with a specified header_name' do
      it "adds the header name to header_row" do
        drill = FactoryGirl.create(:drill)
        drill.add_column("Specified")
        drill.header_row[(drill.header_row.size-1).to_s] == "Specified"
      end

      it "adds the header name to the column field in its children exercise_items" do
        drill = FactoryGirl.create(:drill)
        drill.add_column("Specified")
        drill.exercise_items.first.column == "Specified"
      end
    end
  end
  describe ".add_row" do
    it "should increase the number of exercises by one" do
      drill = FactoryGirl.create(:drill)
      initial_num = drill.exercises.size
      drill.add_row("Add Row Prompt")
      drill.exercises.size.should be == initial_num + 1
    end

  end
  describe '.columns' do
    it "tells how many elements are in the header_row" do
      drill = FactoryGirl.create(:drill)
      drill.columns.should == drill.header_row.size
    end
  end
end