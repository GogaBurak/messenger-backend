require 'rails_helper'

RSpec.describe "Sessions" do
  subject { SessionsController }
  let(:params) { params_for(:user) }

  describe "POST #login" do
    before do
      create(:user)  
    end

    context "with valid params" do
      it "returns http ok" do
        post login_path, params: params
        expect(response).to have_http_status(:ok)
      end
      it "returns token" do
        post login_path, params: params
        expect(response.parsed_body).to include("token")
      end
    end
    context "with non-existing phone" do
      it "returns http bad_request" do
        params[:user][:phone].chop!
        
        post login_path, params: params
        expect(response).to have_http_status(:bad_request)
      end
    end
    context "with invalid password" do
      it "returns http bad_request" do
        params[:user][:password].chop!
        
        post login_path, params: params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "POST #signup" do
    context "with valid params" do
      it "returns http created" do
        post signup_path, params: params_for(:user)
        expect(response).to have_http_status(:created)
      end
      it "creates user" do
        expect{ post signup_path, params: params_for(:user) }.to change(User, :count).by(1)
      end
      it "returns token" do
        post signup_path, params: params_for(:user)
        expect(response.parsed_body).to include("token")
      end
    end
    context "with existing phone" do
      before do
        create(:user)  
      end

      it "returns http bad_request" do
        post signup_path, params: params_for(:user)
        expect(response).to have_http_status(:bad_request)
      end
      it "returns error" do
        invalid_user = User.new
        invalid_user.errors.add(:phone, :taken)
        expected_errors = invalid_user.errors.to_hash

        post signup_path, params: params_for(:user)
        expect(response.parsed_body.as_json).to eq({ erorrs: expected_errors }.as_json)
      end
    end
  end

  describe "DELETE #logout", skip_authorization: true do
    # it "returns http no_content" do
    #   delete logout_path
    #   expect(response).to have_http_status(:no_content)
    # end
    it "returns http not_implemented" do
      delete logout_path
      expect(response).to have_http_status(:not_implemented)
    end
  end
end
