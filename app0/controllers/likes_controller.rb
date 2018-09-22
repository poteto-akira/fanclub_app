class LikesController < ApplicationController
  # before_actionに「:authenticate_user」を追加してください
  # before_action :authenticate_user

  # createアクションを追加してください
  def create
    @like = Like.new(
      user_id: current_user.id,
      post_id: params[:post_id])
    @like.save
    redirect_to("/") #今はとりあえずindexにredirectしてる。本当はファンクラブ詳細ページに戻る。
    @likes = Like.where(post_id: params[:post_id])
  end

  def destroy
    @like = Like.find_by(
      user_id: current_user.id,
      posts_id: params[:post_id])
      @like.destroy
      redirect_to("/") #今はとりあえずindexにredirectしてる。本当はファンクラブ詳細ページに戻る。
  end

end
