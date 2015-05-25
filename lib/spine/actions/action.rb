module Spine
  module Actions
    class Action
      extend Filters
      include Responder
      include Formats
      include Parameters

      attr_reader :env, :request, :response

      def initialize(env)
        @env = env
        @request = Rack::Request.new(env)
        @response = Rack::Response.new
      end

      def self.call(env)
        handler = new(env)

        process_filters(handler, before_filters_with_parents)
        return handler.response.finish if handler.responded?

        handler.action
        process_filters(handler, after_filters_with_parents)

        raise StandardError.new('No response defined') unless handler.responded?
        handler.response.finish
      end
    end
  end
end
