

desc "Trigger backup on Heroku"
task :backup_heroku_db do
  exec "heroku pg:backups capture --app ocill"
end

desc "Retrieve and store latest.dump"
task :download_backup do
  exec "curl -o latest.dump `heroku pg:backups public-url --app ocill`"
end 

desc "Overwrite local database with local backup"
task :overwrite_db_with_backup do
  config = Rails.configuration.database_configuration["development"]

  exec "pg_restore --verbose --clean --no-acl --no-owner -h #{config["host"]} -U #{config["username"]} -w -d #{config["database"]} latest.dump"
end

desc "Update local database"
task :update_local_database => [:backup_heroku_db, :download_backup, :overwrite_db_with_backup] do
  puts "Update complete!"
end

task :update_db_existing_backup => [ :download_backup, :overwrite_db_with_backup ] do
  puts "Update complete!"
end