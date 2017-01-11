# frozen_string_literal: true

module GeoTasks
  module Routing
    module Tasks
      def self.registered(app)
        app.post '/task' do
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
      end
    end
  end
end
