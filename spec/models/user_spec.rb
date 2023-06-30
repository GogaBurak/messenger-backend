# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject { build(:user) }

  describe 'Validations' do
    it { should validate_presence_of(:phone) }
    it { should validate_uniqueness_of(:phone).case_insensitive }
    it { should validate_presence_of(:password) }

    context 'with valid attributes' do
      it { expect(subject).to be_valid }
    end
  end
end
