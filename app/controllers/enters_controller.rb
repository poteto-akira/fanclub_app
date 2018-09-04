class EntersController < ApplicationController
  before_action :authenticate_user!

  # ファンクラブに入会するときのアクション
  def create
    @post = Post.find_by(id: params[:id])
    @enter = Enter.new(
                user_id: current_user.id,
                post_id: params[:post_id]
                )
    @enter.save
    redirect_to("/")
  end

  # ファンクラブの中身ページのアクション
  def show
  end

end
