class AddColumnUserIdAndCourseIDtoRoles < ActiveRecord::Migration
  def up
    add_column :roles, :user_id, :integer
    add_column :roles, :course_id, :integer
    remove_column :users, :role
  end

  def down
    remove_column :roles, :user_id
    remove_column :roles, :course_id
    add_column :users, :role, :string
  end
end
