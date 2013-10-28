class AddLtiUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lti_user_id, :string
  end
end
