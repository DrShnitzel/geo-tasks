# frozen_string_literal: true

module GeoTasks
  module Routing
    module Helper
      def parse_body
        body = request.body.read
        JSON.parse(body, symbolize_names: true)
      rescue JSON::ParserError
        halt 400, { error: 'Invalid JSON' }.to_json
      end

      def validate_coordinate_param(par)
        return if par.class == Array &&
                  par.size == 2 &&
                  par[0].class == Float &&
                  par[1].class == Float
        raise ValidationError
      end
    end
  end
end
