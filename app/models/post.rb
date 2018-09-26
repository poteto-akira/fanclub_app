class Post < ApplicationRecord
  belongs_to :user
  validates :fc_name, {presence: true , length: { maximum: 10 }}
  validates :content, {presence: true}
  validates :post_image, {presence: true}
  # validates :post_image, {presence: true}
  # validates :user_id, {presence: true}

  # has_many :fc_contents
  default_scope -> { order(created_at: :desc) }

  def user
    return User.find_by(id: self.user_id)
  end

  # def contents
  #   return FcContent.where(fc_id: self.id)
  # end

  def contents
    return FcContent.where(fc_id: self.id)
  end
  # def like_user(user_id)
  #   likes.find_by(user_id: user_id)
  # end
end
