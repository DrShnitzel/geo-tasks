# frozen_string_literal: true

namespace :db do
  desc 'Create mongoDB indexes for application models'
  task :create_indexes do
    User.create_indexes
    Task.create_indexes
  end

  desc 'Add some records to db'
  task :seed do
    User.create(role: 'Manager', token: 'manager_token_1')
    User.create(role: 'Manager', token: 'manager_token_2')
    User.create(role: 'Manager', token: 'manager_token_3')
    User.create(role: 'Driver', token: 'driver_token_1')
    User.create(role: 'Driver', token: 'driver_token_2')
    User.create(role: 'Driver', token: 'driver_token_3')
  end
end
