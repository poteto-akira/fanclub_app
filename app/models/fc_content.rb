class FcContent < ApplicationRecord
  # validates :fc_id,{presence: true}

  # belongs_to :post
  def post
    return Post.find_by(id: self.id)
  end
end
