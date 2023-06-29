require 'factory_bot'
require 'pry'

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
