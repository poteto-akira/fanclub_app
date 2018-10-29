class FcContentsController < ApplicationController
  before_action :authenticate_user!

  def index
    # URLにあるPost.idを取得する
    @post = Post.find_by(id: params[:id])
  end

  def show
    @post = Post.find_by(id: params[:id])
    @content = FcContent.find_by(id: params[:id])
    @content = FcContent.new
  end

  def new
    # @content = FcContent.find_by(id: params[:id])
    # @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.find_by(id: params[:id])
    # form_tagに@post.idを含ませて現在閲覧中のfc.idを取得している
    @content = FcContent.new(content_body: params[:content_body],
                             user_id: current_user.id,
                             post_id: params[:id],
                             username: current_user.name)
    respond_to do |format|
      if @content.save
        format.html
        format.js #index.js.htmlに移動
      else
        format.js {render :index}
      end
    end
  end

  private
    def content_params
      params.require(:content).permit(:content_content_body, :post_id, :user_id, :username)
    end

    def fccontent_params
      params.require(:fc_content).permit(:content_body)
    end

end
