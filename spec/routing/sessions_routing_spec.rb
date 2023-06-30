# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  describe 'routing' do
    it { should route(:post, '/login').to(action: :login) }
    it { should route(:post, '/signup').to(action: :signup) }
    it { should route(:delete, '/logout').to(action: :logout) }
  end
end
