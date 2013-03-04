require 'spec_helper'
describe GridDrill do
  describe '.add_column' do
    it "adds a header if none exists" do
      grid_drill = FactoryGirl.create(:grid_drill)
      initial_header_row_size = grid_drill.headers.size
      grid_drill.add_column

      grid_drill.headers.size.should be initial_header_row_size + 1
    end

    it "adds an additional header row to the current collection" do
      grid_drill = FactoryGirl.create(:five_headered_grid_drill)
      initial_header_row_size = grid_drill.headers.size
      grid_drill.add_column
      grid_drill.headers.size.should be initial_header_row_size + 1
    end

    it "adds an exercise if none exist" do
      grid_drill = FactoryGirl.create(:grid_drill)
      before_exercises_size = grid_drill.exercises.size
      grid_drill.add_column("New Header")
      after_exercises_size = grid_drill.exercises.size

      after_exercises_size.should == before_exercises_size + 1
    end
    
    it "adds an additional exercise_item to each child exercise" do
      grid_drill = FactoryGirl.create(:five_exercised_grid_drill)
      grid_drill.add_column("New Header")
      grid_drill.exercise_items.size.should == grid_drill.exercises.size
    end

    describe 'with a specified header_name' do
      it "adds the header name to header_row" do
        grid_drill = FactoryGirl.create(:grid_drill)
        grid_drill.headers.where(:title => "Specified").size.should == 0
        grid_drill.add_column("Specified")
        grid_drill.headers.where(:title => "Specified").size.should == 1
      end

      it "adds the header name to the column field in its children exercise_items" do
        grid_drill = FactoryGirl.create(:grid_drill)
        grid_drill.add_column("Specified")
        grid_drill.exercise_items.first.header == "Specified"
      end
    end
  end
  
  describe ".remove_column" do
    it "should destroy the column header" do
      pending()
    end
    it "should remove the exercise_item from each exercise that matches the deleted header" do
      pending()
    end
    it "should do other things" do
      pending()
    end
  end
  describe ".add_row" do
    it "should increase the number of exercises by one" do
      grid_drill = FactoryGirl.create(:grid_drill)
      initial_num = grid_drill.exercises.size
      grid_drill.add_row("Add Row Prompt")
      grid_drill.exercises.size.should be == initial_num + 1
    end
  end

  describe ".remove_row" do
    it "should remove one exercise and all its children" do
      grid_drill = FactoryGirl.create(:twenty_five_grand_childed_grid_drill)
      exercise = grid_drill.exercises.first
      initial_exercise_count = grid_drill.exercises.count 
      initial_exercise_item_count = grid_drill.exercise_items.count
      grid_drill.remove_row(exercise.id)
      grid_drill.exercises.count.should == initial_exercise_count + 1
      grid_drill.exercise_items.count.should < initial_exercise_item_count
      grid_drill.exercises should_not include(exercise)
    end
  end

  describe '.columns' do
    it "tells how many elements are in the header_row" do
      grid_drill = FactoryGirl.create(:grid_drill)
      grid_drill.columns.should == grid_drill.headers.size
    end
  end
end