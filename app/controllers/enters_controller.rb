class EntersController < ApplicationController
  before_action :authenticate_user!

  # ファンクラブに入会するときのアクション
  def create
    @post = Post.find_by(id: params[:id])
    @enter = Enter.new(
                user_id: current_user.id,
                post_id: params[:id]
                )
    @enter.save
    # saveした後にfc_contents/indexページに飛びたい
    flash[:notice] = "入会できました！"
    redirect_to("/fc_contents/index/#{@post.id}")
  end

  # 加入しているファンクラブ一覧を表示
  def enters
    @user = User.find_by(id: params[:id])
    @enters = Enter.where(user_id: @user.id)
  end


end
