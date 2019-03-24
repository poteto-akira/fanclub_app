class FcContentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.find_by(id: params[:id])
    # TODO: パラメータをprivateメソッドにする
    @content = FcContent.new(content_body: params[:content_body],
                             user_id: current_user.id,
                             post_id: params[:id],
                             username: current_user.name)
    respond_to do |format|
      if @content.save
        format.html
        format.js
      else
        format.js {render :index}
      end
    end
  end
end
