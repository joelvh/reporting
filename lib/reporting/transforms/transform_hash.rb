require_relative '../transform'
require_relative '../matcher'

module Reporting
  module Transforms
    class TransformHash < Transform
      def call(row, context)
        row.each_with_object({}) do |(key, value), result|
          next if slice?(key, value)
          result[transform_key(key)] = transform_value(value)
        end
      end

      def transform_key(key, value)
        key
      end

      def transform_value(key, value)
        value
      end

      def slice?(key, value)
        !match?(key)
      end

      def match?(value)
        return true if @args.empty?

        @matcher ||= Matcher.new(@args)
        @matcher.match?(value)
      end
    end
  end
end
