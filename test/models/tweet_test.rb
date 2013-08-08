require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "tweet can get user's name" do
  	tweet = tweets(:one)
  	assert_equal tweet.user.name, "MyString"
  end

  test "tweet with valid params should save" do
  	tweet = Tweet.new(content: "valid content")
  	tweet.user = users(:one)
  	assert tweet.valid?
  end

  test "tweet can't be blank" do
  	tweet = Tweet.new(content: "")
  	assert !tweet.valid?
  	assert tweet.errors[:content].any? # without this it will fail if user validation exists!
  end
	
	test "tweet can't be longer than 140 chars" do
    string = "a"* 141
    tweet = Tweet.new(content: string)
  end
end
