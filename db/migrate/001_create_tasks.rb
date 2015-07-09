require 'sequel'
require 'sqlite3'
require_relative '../../app/models/task_manager'

environments = %w(test development)

environments.each do |environment|
  Sequel.sqlite("db/task_manager_#{environment}.sqlite3").create_table :tasks do
  primary_key :id
  String      :title
  String      :description
  end

end