# frozen_string_literal: true

require 'factory_bot'
require 'pry'

module FactoryBot
  module Syntax
    # add custom method for generating controller params
    module Methods
      def params_for(model_name, options = {})
        {
          model_name => attributes_for(model_name, options)
        }
      end
    end
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
