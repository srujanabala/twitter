class User < ActiveRecord::Base
	has_many :tweets
  has_many :comments_about_me, as: :commentable, class_name: "Comment"
  has_many :comments_by_me, class_name: "Comment", foreign_key: "author"

	mount_uploader :avatar, AvatarUploader

  has_secure_password

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user| # Find user where provider is facebook or other provider, and the user id is the :uid. First or initialize handles whether the user is new or already exists.
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.password = auth.credentials.token
      user.password_confirmation = auth.credentials.token
      user.handle = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
