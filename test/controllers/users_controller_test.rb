require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def login_as(user)
    session[:user_id] = user
  end

  test "confirm user exists" do
    login_as(users(:one))
    get :confirm, id: 1
    assert_response :success
  end

  test "confirm user url" do
    get :confirm, id: 1
    assert_response :redirect
  end

  test "create user sends confirmation email" do
    user = users(:one)

    ActionMailer::Base.deliveries.clear

    post :create, user: {name: user.name, email: user.email, handle: user.handle}

    invite_email = ActionMailer::Base.deliveries.last

    assert_equal user.email, invite_email.to[0]
  end
end
