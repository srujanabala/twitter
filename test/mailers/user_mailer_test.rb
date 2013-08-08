require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
	tests UserMailer
  # test "the truth" do
  #   assert true
  # end

  test "user confirmation email is sent to a new user's email" do
  	user = users(:one)
  	email = UserMailer.confirm_email(user).deliver

  	assert !ActionMailer::Base.deliveries.empty?

    assert_equal ['test@twitter.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'Confirm your email for Shitty Twitter', email.subject
  end
end
