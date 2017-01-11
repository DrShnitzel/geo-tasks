# frozen_string_literal: true

module GeoTasks
  module Routing
    module Tasks
      def self.registered(app)
        app.post '/tasks' do
          body_params = parse_body
          user = User.auth_by(token: body_params[:token])
          validate_coordinate_param(body_params[:pickup_location])
          validate_coordinate_param(body_params[:delivery_location])
          task = user.create_task(
            pickup_location: body_params[:pickup_location],
            delivery_location: body_params[:delivery_location]
          )
          halt({ _id: task.id.to_s }.to_json)
        end

        app.post '/tasks/nearby' do
          body_params = parse_body
          User.auth_by(token: body_params[:token])
          validate_coordinate_param(body_params[:driver_location])
          tasks = Task.tasks_nearby(body_params[:driver_location])
          halt format_tasks(tasks).to_json
        end

        app.put '/tasks/pick' do
          body_params = parse_body
          user = User.auth_by(token: body_params[:token])
          task = user.assign_task(task_id: body_params[:_id])
          resp = { _id: task.id.to_s, status: task.status }
          halt resp.to_json
        end

        app.put '/tasks/complete' do
          body_params = parse_body
          user = User.auth_by(token: body_params[:token])
          task = user.complete_task
          resp = { _id: task.id.to_s, status: task.status }
          halt resp.to_json
        end
      end
    end
  end
end
