# frozen_string_literal: true

module GeoTasks
  module Routing
    module Tasks
      def self.registered(app)
        app.post '/task' do
          body_params = parse_body
          user = User.auth_by(token: body_params[:token])
        end
      end
    end
  end
end
