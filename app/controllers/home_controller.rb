class HomeController < ApplicationController
  before_action :authenticate_user!, only:[:new_fc, :create, :edit_fc, :setting,
                                    :edit_account, :edit_profile]


  def index
    @posts = Post.all.order(created_at: :desc)
    @users = User.all.order(created_at: :desc)
    @likes = Like.where(post_id: params[:post_id])
  end

  def new_fc
  end


  def create
    @post = Post.find_by(id: params[:id])
    @post = Post.new(content: params[:content],
                     user_id: current_user.id,
                     fc_name: params[:fc_name],
                     post_image: "default_post.jpg")

    if @post.save
    # ここから画像保存処理してるんだけどPost.newでpost_iamge: params[:post_image]
    # をしてるからpostテーブルに--.jpgの形で保存されていない。
    if params[:post_image]
      # 画像のリサイズをする

      # アップロードした画像を300x300のサイズに編集
      image = MiniMagick::Image.read(params[:post_image])
      image.resize "200x200"
      @post.post_image = "#{@post.id}.jpg"
      # image = params[:post_image]
      # File.binwrite("public/post_images/#{@post.post_image}",image.read )
      image.write "public/post_images/#{@post.post_image}"
    end


      redirect_to(root_path)
      # flash[:notice] = "ファンクラブを作成しました！これから素晴らしいファンクラブにしていってくださいね♡"
    else
      render("new_fc")

    end
  end


  def show_fc
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @member_count = Enter.where(post_id: @post.id).count
  end

  def edit_fc
    @post = Post.find_by(id: params[:id])
  end

  def update_fc
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.fc_name = params[:fc_name]

    if params[:post_image]
      # @post.post_image = "#{@post.id}.jpg"
      # image = params[:post_image]
      # リサイズしてから保存
      @post.post_image = "#{@post.id}.jpg"
      image = MiniMagick::Image.read(params[:post_image])
      image.resize "200x200"
      image.write "public/post_images/#{@post.post_image}"

      # File.binwrite("public/post_images/#{@post.post_image}",image.read )
    end


    @post.post_image = "#{@post.id}.jpg"

    if @post.save
      flash[:notice] = "編集完了！！！"
      redirect_to("/#{@post.id}/show_fc")
    else
      render("edit_fc")
    end
  end

  def profile
    @user = User.find_by(id: params[:id])
    @post = Post.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def update_user
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    # @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.id}.jpg",image.read)
    end
    @user.save
    flash[:notice] = "ユーザー情報を編集しました"
    redirect_to("/home/profile/#{@user.id}")

  end



  def likes
    @user = User.find_by(id: params[:id])
    @post = Post.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/")
  end

  def setting
  end

  def edit_account
  end

  def edit_profile
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  # 加入しているファンクラブ一覧を表示
  def enters
    @user = User.find_by(id: params[:id])
    @enters = Enter.where(user_id: @user.id)
  end
end
