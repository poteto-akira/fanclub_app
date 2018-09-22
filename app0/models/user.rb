class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :image_name, ImagesUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :posts
  # has_many :fc_name


  def posts
    return Post.where(user_id: self.id)
  end

  # def set_image(file)
  #     if !file.nil?
  #       file_name = file.original_filename
  #       File.open("public/user_images/#{file_name}", 'wb') { |f|
  #         f.write(file.read)
  #       }
  #       image_name = file_name
  #     end
  # end

end
