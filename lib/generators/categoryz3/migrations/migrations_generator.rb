require 'rails/generators'
require 'rails/generators/migration'

class Categoryz3::MigrationsGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../../../../../db/migrate', __FILE__)

  def copy_migrations
    migration_template "20121003060539_create_categoryz3_categories.rb", "db/migrate/create_categoryz3_categories.rb"
    migration_template "20121003060933_create_categoryz3_items.rb", "db/migrate/create_categoryz3_items.rb"
    migration_template "20121003061056_create_categoryz3_child_items.rb", "db/migrate/create_categoryz3_child_items.rb"
  end

  def self.next_migration_number( dirname )
    next_migration_number = current_migration_number(dirname) + 1
    if ActiveRecord::Base.timestamped_migrations
      [Time.now.utc.strftime("%Y%m%d%H%M%S%6N"), "%.20d" % next_migration_number].max
    else
      "%.3d" % next_migration_number
    end
  end
end
