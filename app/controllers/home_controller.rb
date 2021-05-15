class HomeController < ApplicationController
  before_action :authenticate_user!,
                only:[:new_fc, :create, :edit_fc, :setting,:edit_account, :edit_profile]

  def index
    @page_name = "HOME"
    @posts = Post.all.order(created_at: :desc)
    @users = User.all.order(created_at: :desc)
    @likes = Like.where(post_id: params[:post_id])
  end

  def new_fc
    @page_name = "NEW FANCLUB"
  end

  def create
    @post = Post.find_by(id: params[:id])
    @post = Post.new(content: params[:content],
                     user_id: current_user.id,
                     fc_name: params[:fc_name],
                     post_image: "default_post.jpg")
    if @post.save
      if params[:post_image]
        image = MiniMagick::Image.read(params[:post_image])
        image.resize "200x200"
        @post.post_image = "#{@post.id}.jpg"
        image.write "public/post_images/#{@post.post_image}"
      end
        redirect_to(root_path)
    else
      render("new_fc")
    end
  end

  def show_fc
    @page_name = "ABOUT"
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @member_count = Enter.where(post_id: @post.id).count
  end

  def edit_fc
    @page_name = "EDIT FANCLUB"
    @post = Post.find_by(id: params[:id])
  end

  def update_fc
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.fc_name = params[:fc_name]
    if params[:post_image]
      @post.post_image = "#{@post.id}.jpg"
      image = MiniMagick::Image.read(params[:post_image])
      image.resize "200x200"
      image.write "public/post_images/#{@post.post_image}"
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
    @page_name = "PROFILE"
    @user = User.find_by(id: params[:id])
    @post = Post.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def update_user
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
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
    @page_name = "SETTING"
  end

  def edit_account
    @page_name = "EDIT ACCOUNT"
  end

  def edit_profile
    @page_name = "EDIT PROFILE"
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def enters
    @user = User.find_by(id: params[:id])
    @enters = Enter.where(user_id: @user.id)
  end

  def fc_list
    @page_name = "LIST"
    @user = User.find_by(id: params[:id])
  end

  def others
  end

  def policy_law
  end
end
