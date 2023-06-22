require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "can' get messages with no auth" do
    get "/messages"
    assert_response :unauthorized
  end
  test "can get messages with header" do
    @user = User.create(phone: "+375445877478", password: "mUc3m00RsqyRe")
    get "/messages", headers: { HTTP_AUTHORIZATION: "Bearer #{build_jwt}", HTTP_ACCEPT: "application/json" }
    assert_response :success
  end
  test "expired jwt fails" do
    @user = User.create(phone: "+375445877478", password: "mUc3m00RsqyRe")
    get "/messages", headers: { "HTTP_AUTHORIZATION" => "Bearer #{build_jwt(-1)}", HTTP_ACCEPT: "application/json" }

    assert_response :unauthorized
  end
  test "can get messages content" do
    @user = User.create(phone: "+375445877478", password: "mUc3m00RsqyRe")
    get "/messages", headers: { "HTTP_AUTHORIZATION" => "Bearer #{build_jwt}", HTTP_ACCEPT: "application/json" }
    res = JSON.parse(@response.body)
    assert_equal "[{\"text\"=>\"it works\"}]", res.to_s
  end

  def build_jwt(valid_for_minutes = 5)
    exp = valid_for_minutes.minutes

    JsonWebToken.encode({ user_id: @user.id }, exp)[:token]
  end
end
