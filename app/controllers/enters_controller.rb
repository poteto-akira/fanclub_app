class EntersController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find_by(id: params[:id])
    @enter = Enter.new(user_id: current_user.id,post_id: params[:id])
    @enter.save
    flash[:notice] = "入会できました！"
    redirect_to("/fc_contents/index/#{@post.id}")
  end

  def enters
    @user = User.find_by(id: params[:id])
    @enters = Enter.where(user_id: @user.id)
  end
end
