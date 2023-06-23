require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  # describe "Associations" do
  #   it { should belong_to(:user) }
  # end

  describe "Validations" do
    let(:user_params) { attributes_for(:user) }

    it { should validate_presence_of(:phone) }
    it { should validate_uniqueness_of(:phone).case_insensitive  }
    it { should validate_presence_of(:password) }
    
    context "with valid attributes" do 
      it "is valid" do
        expect( subject ).to be_valid
      end
    end
  end
end
