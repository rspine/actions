require 'spine/content_types'

module Spine
  module Actions
    module Formats
      def format
        ContentTypes::Html
      end
    end
  end
end
