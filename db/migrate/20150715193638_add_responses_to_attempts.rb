class AddResponsesToAttempts < ActiveRecord::Migration
  def up
    add_column :attempts, :response, :text

    attempts = ActiveRecord::Base.connection.execute('Select attempts.* FROM attempts')
    attempts.each do |a|
      responses_json = ActiveRecord::Base.connection.execute("Select responses.* FROM responses WHERE attempt_id=" + a['id']).to_json
      ActiveRecord::Base.connection.execute("UPDATE attempts SET response = #{ActiveRecord::Base.sanitize(responses_json)} WHERE attempts.id=" + a['id'])
    end
  end

  def down
    remove_column :attempts, :response
  end

end
