module Spine
  module Actions
    module Filters
      def before(method_name)
        before_filters << method_name
      end

      def after(method_name)
        after_filters << method_name
      end

      def process_filters(handler, filters)
        filters.detect do |name|
          handler.public_send(name) if handler.respond_to?(name)
          handler.responded?
        end
      end

      def before_filters
        @before_filters ||= []
      end

      def before_filters_with_parents
        if superclass.respond_to?(:before_filters_with_parents)
          superclass.before_filters_with_parents + before_filters
        else
          before_filters
        end
      end

      def after_filters
        @after_filters ||= []
      end

      def after_filters_with_parents
        if superclass.respond_to?(:after_filters_with_parents)
          after_filters + superclass.after_filters_with_parents
        else
          after_filters
        end
      end
    end
  end
end
