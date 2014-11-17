require 'rails/generators/migration'

class DeviseTraceableGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration

  desc 'Generates a tracing model to trace devise model with the given NAME' <<
    ' also generates devise model if does not exist.'

  def self.source_root
    @_devise_source_root ||= File.expand_path("../templates", __FILE__)
  end

  def self.orm_has_migration?
    Rails::Generators.options[:rails][:orm] == :active_record
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  class_option :orm
  class_option :migration, :type => :boolean, :default => orm_has_migration?

  def invoke_orm_model
    if options[:orm].present?
      unless model_exists?
        invoke 'devise', [name]
      end
      inject_devise_traceable_option
      Rails::Generators.invoke 'model', ["#{name}Tracing", '--no-migration']
    else
      abort "Cannot create a '#{name}Tracing' model because config.generators.orm is blank.\n" <<
        "Please create your model by hand or configure your generators orm before calling `rails g devise_traceable #{name}`."
    end
  end

  def create_migration_file
    migration_template 'migration.rb', "db/migrate/devise_create_#{name.underscore}_tracings.rb"
  end

  protected

  def model_exists?
    File.exists?(File.join(destination_root, model_path))
  end

  def model_path
    @model_path ||= File.join("app", "models", "#{file_path}.rb")
  end
end
