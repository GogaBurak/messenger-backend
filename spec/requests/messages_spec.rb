# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', skip_authorization: true do
  describe 'GET /messages' do
    let(:user) { create(:user) }

    before { get messages_path }

    it { expect(response.parsed_body).to eq([{ 'text' => 'it works' }]) }
  end
end
