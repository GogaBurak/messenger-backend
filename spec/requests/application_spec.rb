require 'rails_helper'

RSpec.describe "ApplicationController methods" do
  before do
    Rails.application.routes.disable_clear_and_finalize = true
    Rails.application.routes.draw do
      get '/authorize_request', to: 'application#authorize_request'
    end
  end

  describe "authorize_request" do
    context "with valid token" do
      it "returns http no_content" do
        user = create(:user)
        token = JsonWebToken.encode({ user_id: user.id }, 5.minutes)[:token]

        get "/authorize_request", headers: { authorization: "Bearer #{token}" }
        expect(response).to have_http_status(:no_content)
      end
    end
    context "without authorization header" do
      it "returns http unauthorized" do
        get "/authorize_request"
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context "with invalid token" do
      it "returns http unauthorized" do
        get "/authorize_request", headers: { authorization: "Bearer invaild_token" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context "with outdated token" do
      it "returns http unauthorized" do
        user = create(:user)
        token = JsonWebToken.encode({ user_id: user.id }, -1.minute)[:token]

        get "/authorize_request", headers: { authorization: "Bearer #{token}" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context "with invalid user_id in token" do
      it "returns http unauthorized" do
        token = JsonWebToken.encode({ user_id: -1 }, 5.minutes)[:token]

        get "/authorize_request", headers: { authorization: "Bearer #{token}" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
