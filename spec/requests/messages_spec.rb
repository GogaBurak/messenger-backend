require 'rails_helper'

RSpec.describe "Messages", skip_authorization: true do
  describe "GET /messages" do
    it "can get messages content" do
      @user = User.create(phone: "+375445877478", password: "mUc3m00RsqyRe")
      get messages_path
      res = JSON.parse(@response.body)
      assert_equal "[{\"text\"=>\"it works\"}]", res.to_s
    end
  end
end