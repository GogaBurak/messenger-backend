require 'rails_helper'

RSpec.describe 'SessionsController', type: :routing do
  describe 'routing' do
    it 'routes to #login' do
      expect(post: "/login").to route_to("sessions#login")
    end
    it 'routes to #signup' do
      expect(post: "/signup").to route_to("sessions#signup")
    end
    it 'routes to #logout' do
      expect(delete: "/logout").to route_to("sessions#logout")
    end
  end
end
