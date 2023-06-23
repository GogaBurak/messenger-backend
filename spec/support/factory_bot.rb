require 'factory_bot'
require 'pry'

module FactoryBot::Syntax::Methods
  def params_for(model_name)
    {
      model_name => attributes_for(model_name)
    }
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end