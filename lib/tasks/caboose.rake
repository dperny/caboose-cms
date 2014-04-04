require "caboose/version"
require "caboose/migrations"

namespace :caboose do  
  
  desc "Creates/verifies that all database tables and fields are correctly added."
  task :db => :environment do
    Caboose::Schema.create_schema
    Caboose::Schema.load_data    
    if class_exists?('Schema')
      Schema.create_schema
      Schema.load_data
    end
  end

  desc "Creates all caboose tables"
  task :create_schema => :environment do Caboose::Schema.create_schema end

  desc "Loads data into caboose tables"
  task :load_data => :environment do Caboose::Schema.load_data end

  #=============================================================================
  
  def class_exists?(class_name)
    klass = Module.const_get(class_name)
      return klass.is_a?(Class)
    rescue NameError
      return false
  end
  
  desc "Resets the admin password to 'caboose'"
  task :reset_admin_pass => :environment do  
    admin_user = Caboose::User.where(username: 'admin').first
    admin_user.password = Digest::SHA1.hexdigest(Caboose::salt + 'caboose')
    admin_user.save    
  end

  desc "Sync production db to development"
  task :sync_dev_db do
    
    ddb = Rails.application.config.database_configuration['development']
    pdb = Rails.application.config.database_configuration['production']
    
    dump_file = "#{Rails.root}/db/backups/#{pdb['database']}_#{DateTime.now.strftime('%FT%T')}.dump"
    if !File.exists?("#{Rails.root}/db/backups")
      `mkdir -p #{Rails.root}/db/backups`
    end
    
    puts "Capturing production database..."
    `heroku pgbackups:capture --expire`
    
    puts "Downloading production database dump file..."
    `curl -o #{dump_file} \`heroku pgbackups:url\``
    
    puts "Restoring development database from dump file..."
    `pg_restore --verbose --clean --no-acl --no-owner -h #{ddb['host']} -U #{ddb['username']} -d #{ddb['database']} #{dump_file}`
    
  end
  
  desc "Loads and refreshes the timezones from timezonedb.com"
  task :load_timezones => :environment do
    Caboose::Timezone.load_zones('/Users/william/Sites/repconnex/tmp/timezones')
  end
  
  desc "Loads and refreshes the timezones from timezonedb.com"
  task :test_timezones => :environment do
    
    d = DateTime.strptime("04/01/2014 10:00 am -0500", "%m/%d/%Y %I:%M %P %Z")
    puts d    
    d = DateTime.strptime("04/01/2014 10:00 am -0700", "%m/%d/%Y %I:%M %P %Z")
    puts d
  end

end

namespace :assets do

  desc "Precompile assets, upload to S3, then remove locally"
  task :purl => :environment do
  
    Rake::Task['assets:precompile'].invoke    
    `mv #{Rails.root.join('public', 'assets', 'manifest.yml')} #{Rails.root.join('public', 'manifest.yml')}`
    `rm -rf #{Rails.root.join('public', 'assets')}`
    `mkdir #{Rails.root.join('public', 'assets')}`     
    `mv #{Rails.root.join('public', 'manifest.yml')} #{Rails.root.join('public', 'assets', 'manifest.yml')}`

  end
  
end
