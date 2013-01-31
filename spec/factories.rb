FactoryGirl.define do
  factory :course do
    title "Title of Course"

    factory :course_with_lessons do
      ignore do 
        lessons_count 5
      end

      after(:create) do |course, evaluator|
        FactoryGirl.create_list(:lesson, evaluator.lessons_count, course: course)
      end
    end
  end

  factory :lesson do
    title "Title of Lesson"

    course

    factory :lesson_with_drills do
      ignore do
        drills_count 5
      end

      after(:create) do |lesson, evaluator|
        FactoryGirl.create_list(:drill, evaluator.drills_count, lesson: lesson)
      end
    end
  end

  factory :drill do
    title "Title of Drill"

    lesson

    factory :drill_with_no_title do
      title ''
    end

   factory :drill_with_exercises do
      ignore do
        exercises_count 5
      end

      after(:create) do |drill, evaluator|
        FactoryGirl.create_list(:exercise, evaluator.exercises_count, drill: drill)
      end
    end

    factory :drill_with_header_row do
      header_row {{ one: "one", two: "two" }}
    end
  end

  factory :listening_drill do 
    title "Title of Listening Drill"

    lesson

    factory :listening_drill_with_exercises do
      ignore do
        exercises_count 5
      end

      after(:create) do |listening_drill, evaluator|
        FactoryGirl.create_list(:exercise, evaluator.exercises_count, listening_drill: listening_drill)
      end
    end    
  end 

  factory :exercise do
    title "Title of Exercise"
    prompt "Prompt of Exercise"

    drill 
    
    factory :empty_exercise do
      title nil
      prompt nil
    end

    factory :exercise_with_five_siblings do
      association :drill, factory: :drill_with_exercises
    end



    factory :exercise_with_exercise_items do
      ignore do
        exercise_items_count 5
      end

      after(:create) do |exercise, evaluator|
        FactoryGirl.create_list(:exercise_item, evaluator.exercise_items_count, exercise: exercise)
      end
    end
  end
  
  factory :exercise_item do
    exercise

    sequence(:column) {|n| "#{n.to_s}"}

    factory :exercise_item_with_type_defined do
      type "Type Defined"
    end

    factory :exercise_item_with_column_defined do
      column "Column Defined"
    end    

    factory :exercise_item_with_five_siblings do
      association :exercise, factory: :exercise_with_exercise_items

    end
    
    factory :exercise_item_with_media_items do
      ignore do
        media_items_count 5
      end

      after(:create) do |exercise_item, evaluator|
        FactoryGirl.create_list(:exercise_item, evaluator.media_items_count, exercise_item: exercise_item)
      end
    end

  end

end