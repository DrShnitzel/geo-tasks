# frozen_string_literal: true

module GeoTasks
  module Routing
    module Errors
      def self.registered(app)
        app.not_found do
          halt 404, { error: 'route not found' }.to_json
        end

        app.error AuthError do
          halt 401, { error: 'incorrect token' }.to_json
        end

        app.error PermissionDenied do
          halt 403, { error: 'permission denied' }.to_json
        end

        app.error HaveNotCompletedTask do
          msg = 'cannot assign new task. existing task must be completed first'
          halt 400, { error: msg }.to_json
        end

        app.error AlreadyAssigned do
          msg = 'cannot assign task. task is already assigned'
          halt 400, { error: msg }.to_json
        end

        app.error NoActiveTasks do
          msg = 'cannot complete task. no tasks assigned to current driver'
          halt 400, { error: msg }.to_json
        end

        app.error ValidationError do
          halt 400, { error: 'request parameters are not correct' }.to_json
        end

        app.error do
          halt 500, { error: 'internal server error' }.to_json
        end
      end
    end
  end
end
