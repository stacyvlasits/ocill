class AddMoreKeys < ActiveRecord::Migration
  def change
    add_foreign_key "drills", "templates", :name => "drills_template_id_fk"
  end
end
