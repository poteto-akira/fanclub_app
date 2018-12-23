class Post < ApplicationRecord
  belongs_to :user
  validates :fc_name, {presence: true , length: { maximum: 10 }}
  validates :content, {presence: true}
  validates :post_image, {presence: true}
  has_many :fc_contents, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  def user
    return User.find_by(id: self.user_id)
  end

  def contents
    return FcContent.where(post_id: self.id)
  end
end
