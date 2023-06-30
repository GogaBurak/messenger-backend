require 'rails_helper'

RSpec.describe 'Sessions' do
  subject { SessionsController }

  describe 'POST #login' do
    before { create(:user) }
    before { post login_path, params: params  }

    context 'with valid params' do
      let(:params) { params_for(:user) }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.parsed_body).to include('token') }
    end
    context 'with non-existing phone' do
      let(:params) { params_for(:user, phone: '+0000000000') }

      it { expect(response).to have_http_status(:bad_request) }
    end
    context 'with invalid password' do
      let(:params) { params_for(:user, phone: '+0000000000') }
  
      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  describe 'POST #signup' do
    context 'with valid params' do
      before { post signup_path, params: params_for(:user)  }

      it { expect(response).to have_http_status(:created) }
      it { expect(response.parsed_body).to include('token') }
    end
    context 'with existing phone' do
      let(:expected_errors) { {'phone'=>['has already been taken']} }

      before { create(:user) }
      before { post signup_path, params: params_for(:user) }

      it { expect(response).to have_http_status(:bad_request) }
      it { expect(response.parsed_body).to eq({'erorrs' => expected_errors}) }
    end
  end

  describe 'DELETE #logout', skip_authorization: true do
    before { delete logout_path }

    # it { expect(response).to have_http_status(:no_content) }
    it { expect(response).to have_http_status(:not_implemented) }
  end
end
