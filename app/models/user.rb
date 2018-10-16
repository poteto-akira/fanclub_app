class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # 画像をアップロードできるようにしている
  # mount_uploader :image_name, ImagesUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]
  validates :name, {presence: true}

  has_many :posts, dependent: :destroy
  has_many :fc_contents, dependent: :destroy
  # has_many :fc_name


  def posts
    return Post.where(user_id: self.id)
  end

# twitterログイン関連
  # def self.find_or_create_from_auth_hash(auth_hash)
  #  provider = auth_hash[:provider] #providerはどのサービスで認証したのかを見分けるもの
  #  uid = auth_hash[:uid]
  #  name = auth_hash[:info][:name]
  #  image_url = auth_hash[:info][:image]
  #
  #  #find_or_create_by()は()の中の条件のものが見つければ取得し、なければ新しく作成するというメソッド
  #  self.find_or_create_by(provider: provider,uid: uid) do |user|
  #    user.username = name
  #    user.image_url = image_url
  #  end
  # end

# twitterログイン関連
  # def self.from_omniauth(auth)
  #   find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
  #     user.provider = auth["provider"]
  #     user.uid = auth["uid"]
  #     user.username = auth["info"]["nickname"]
  #   end
  # end
  #
  # def self.new_with_session(params, session)
  #   if session["devise.user_attributes"]
  #     new(session["devise.user_attributes"]) do |user|
  #       user.attributes = params
  #     end
  #   else
  #     super
  #   end
  # end

  # def self.find_for_oauth(auth)
  #   user = User.where(uid: auth.uid, provider: auth.provider).first
  #
  #   unless user
  #     user = User.create(
  #       uid:      auth.uid,
  #       provider: auth.provider,
  #       email:    User.dummy_email(auth),
  #       password: Devise.friendly_token[0, 20],
  #       image: auth.info.image,
  #       name: auth.info.name,
  #       nickname: auth.info.nickname,
  #       location: auth.info.location
  #     )
  #   end
  #
  #   user
  # end
  #
  # private
  #
  # def self.dummy_email(auth)
  #   "#{auth.uid}-#{auth.provider}@example.com"
  # end

  # OmniAuth認証データを元にデータベースでユーザーを探す。なければ新しく作る。
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid      = auth.uid
        user.name = auth.info.name
        user.username = auth.info.nickname
        user.remote_image_name_url = auth.info.image
        # DBに仮のメアドを保存
        user.email = auth["email"].nil? ? auth["provider"] + auth["uid"] + "@login.function" : auth["email"]

        # パスワード不要なので、パスワードには触らない。
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
