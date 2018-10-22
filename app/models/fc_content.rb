class FcContent < ApplicationRecord
  # validates :fc_id,{presence: true}
  validates :content_body, {presence: true}
  # controllerでdescできなかったからここで新着順に並び替えている
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  # belongs_to :post


  def post
    return Post.find_by(id: self.id)
  end

# contentのuser_idからuser.remote_image_name_urlを取得したい
  def content_user_remote_image_name_url
    return User.find_by(id: self.user.id)
  end


end
