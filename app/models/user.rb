class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:timeoutable, :omniauthable, omniauth_providers: [:twitter]
  validates :name, {presence: true}
  has_many :posts, dependent: :destroy
  has_many :fc_contents, dependent: :destroy

  def posts
    return Post.where(user_id: self.id)
  end

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid      = auth.uid
        user.name = auth.info.name
        user.username = auth.info.nickname
        user.remote_image_name_url = auth.info.image
        user.email = auth["email"].nil? ? auth["provider"] + auth["uid"] + "@login.function" : auth["email"]
      end
    end

    # session["devise.user_attributes"]が存在する場合、それとparamsを組み合わせてUser.newできるよう、Deviseの実装をOverrideする。
    def self.new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"]) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end

    # ログイン時、OmniAuthで認証したユーザーのパスワード入力免除するため、Deviseの実装をOverrideする。
    def password_required?
      super && provider.blank?  # provider属性に値があればパスワード入力免除
    end

    # ログイン時、OmniAuthで認証したユーザーのメアド入力免除するため、Deviseの実装をOverrideする。
    def email_required?
      super && provider.blank?  # provider属性に値があればメアド入力免除
    end

    # Edit時、OmniAuthで認証したユーザーのパスワード入力免除するため、Deviseの実装をOverrideする。
    def update_with_password(params, *options)
      if encrypted_password.blank?            # encrypted_password属性が空の場合
        update_attributes(params, *options)   # パスワード入力なしにデータ更新
      else
        super
      end
    end
end
