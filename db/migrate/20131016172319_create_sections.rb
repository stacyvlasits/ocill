class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :lti_course_id, index: true
      t.timestamps
    end
  end
end
