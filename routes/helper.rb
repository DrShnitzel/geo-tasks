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
    end
  end
end
