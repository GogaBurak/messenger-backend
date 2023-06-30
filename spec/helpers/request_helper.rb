# frozen_string_literal: true

# add default header to spec requests
module RequestHelper
  %i[get post patch put delete].each do |method_name|
    define_method(method_name) do |path, args = {}|
      default_options = {}

      # set default header for testing API
      args[:headers] ||= {}
      args[:headers][:accept] = 'application/json'

      process method_name, path, **default_options.merge(args)
    end
  end
end
