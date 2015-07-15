class AddResponsesToAttempts < ActiveRecord::Migration
  def up
    add_column :attempts, :response, :text

    Attempt.find_each do | attempt |
      attempt.response = attempt.responses.as_json
      attempt.save
    end
  end

  def down
    remove_column :attempts, :response
  end

end
