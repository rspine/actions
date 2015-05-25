require 'rack'
require 'uri'

module Spine
  module Actions
    module Responder
      def responded?
        @responded
      end

      def respond(content, options = {})
        response[Rack::CONTENT_TYPE] = options.fetch(:content_type) {
          format.mime_type
        }
        response.status = options[:status] if options[:status]
        response.write(format.dump(content))

        finish_response
      end

      def send_data(binary, options = {})
        response['Content-Transfer-Encoding'] = 'binary'
        response[Rack::CONTENT_TYPE] = options.fetch(:content_type, 'application/octet-stream')

        if options[:filename]
          response['Content-Disposition'] = "inline; filename='#{ options[:filename] }'"
        end
        response.write(binary)

        finish_response
      end

      def redirect(url, options = {})
        response[Rack::CONTENT_TYPE] = 'application/x-www-form-urlencoded'
        response.redirect(
          build_url(url, options.fetch(:data, {})),
          options.fetch(:status, 302)
        )

        finish_response
      end

      def finish_response
        @responded = true
        response
      end

      def build_url(url, data)
        uri = URI(url)
        query = URI.decode_www_form(uri.query || '') || []
        uri.query = URI.encode_www_form(query + data.to_a)
        uri.to_s
      end
    end
  end
end
