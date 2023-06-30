# frozen_string_literal: true

require 'factory_bot'
require 'pry'

# add custom method for generating controller params
module FactoryBot::Syntax::Methods
  def params_for(model_name, options = {})
    {
      model_name => attributes_for(model_name, options)
    }
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
