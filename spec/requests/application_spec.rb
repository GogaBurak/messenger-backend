require 'rails_helper'

RSpec.describe ApplicationController do
  before do
    Rails.application.routes.disable_clear_and_finalize = true
    Rails.application.routes.draw do
      get '/authorize_request', to: 'application#authorize_request'
    end
  end

  describe "authorize_request" do
    before(:each) { get "/authorize_request", headers: headers }

    context "with valid token" do
      let(:headers) do
        user = create(:user)
        token = JsonWebToken.encode({ user_id: user.id }, 5.minutes)[:token]

        { authorization: "Bearer #{token}" }
      end 

      it { expect(response).not_to have_http_status(:unauthorized) }
    end
    context "without authorization header" do
      it { expect(response).to have_http_status(:unauthorized) }
    end
    context "with invalid token" do
      let(:headers) { { authorization: "Bearer invaild_token" } }

      it { expect(response).to have_http_status(:unauthorized) }
    end
    context "with outdated token" do
      let(:headers) do
        user = create(:user)
        token = JsonWebToken.encode({ user_id: user.id }, -1.minute)[:token]

        { authorization: "Bearer #{token}" }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
    context "with invalid user_id in token" do
      let(:headers) do
        token = JsonWebToken.encode({ user_id: -1 }, 5.minutes)[:token]

        { authorization: "Bearer #{token}" }
      end 

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
