require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "can' get messages with no auth" do
    get "/messages"
    assert_response :unauthorized
  end
  test "can get messages with header" do
    @user = User.create(phone: "+375445877478", password: "mUc3m00RsqyRe")
    get "/messages", headers: { "HTTP_AUTHORIZATION" => "Bearer " + build_jwt }
    assert_response :success
  end
  test "expired jwt fails" do
    @user = User.create(phone: "+375445877478", password: "mUc3m00RsqyRe")
    get "/messages", headers: { "HTTP_AUTHORIZATION" => "Bearer " + build_jwt(-1) }

    assert_response :unauthorized
  end
  test "can get messages content" do
    @user = User.create(phone: "+375445877478", password: "mUc3m00RsqyRe")
    get "/messages", headers: { "HTTP_AUTHORIZATION" => "Bearer " + build_jwt }
    res = JSON.parse(@response.body)
    assert_equal '{"messages"=>["it works"]}', res.to_s
  end

  def build_jwt(valid_for_minutes = 5)
    exp = Time.now.to_i + (valid_for_minutes*60)

    JsonWebToken.encode({ user_id: @user.id }, exp)
  end
end
