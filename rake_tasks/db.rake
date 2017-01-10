# frozen_string_literal: true

namespace :db do
  desc 'Create mongoDB indexes for application models'
  task :create_indexes do
    User.create_indexes
    Task.create_indexes
  end
end
