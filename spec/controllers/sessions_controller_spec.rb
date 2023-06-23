require 'rails_helper'

RSpec.describe SessionsController, type: :controller  do
  render_views
  
  let(:params) { params_for(:user) }

  describe "POST #login" do
    before do
      create(:user)  
    end

    it "returns http ok" do
      post :login, params: params
      expect(response).to have_http_status(:ok)
    end
    it "returns token" do
      post :login, params: params
      expect(response.parsed_body).to include("token")
    end
  end

  describe "POST #signup" do
    it "returns http created" do
      post :signup, params: params_for(:user)
      expect(response).to have_http_status(:created)
    end
    it "creates user" do
      expect{ post :signup, params: params_for(:user) }.to change(User, :count).by(1)
    end
    it "returns token" do
      post :signup, params: params_for(:user)
      expect(response.parsed_body).to include("token")
    end
  end

  describe "DELETE #logout", authorized: true do
    # it "returns http no_content" do
    #   delete :logout
    #   expect(response).to have_http_status(:no_content)
    # end
    it "returns http not_implemented" do
      delete :logout
      expect(response).to have_http_status(:not_implemented)
    end
  end

end
