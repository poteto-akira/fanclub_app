class FcContent < ApplicationRecord
  validates :content_body, {presence: true}
  default_scope -> { order(created_at: :desc) }
  belongs_to :user

  def post
    return Post.find_by(id: self.id)
  end

  def content_user_remote_image_name_url
    return User.find_by(id: self.user.id)
  end
end
