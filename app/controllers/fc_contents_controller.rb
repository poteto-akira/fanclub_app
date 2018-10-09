class FcContentsController < ApplicationController
  before_action :authenticate_user!

  def index
    # render :layout => "index.html.erb"
    @post = Post.find_by(id: params[:id])
    # ここでorderしてもダメだからfc_content.rbで書いている
    # @contents = FcContent.all.order(created_at: :desc)
    @content = FcContent.new
    # @contents = @post.content
  end

  def show
    @post = Post.find_by(id: params[:id])
    @content = FcContent.find_by(id: params[:id])
    @content = FcContent.new
    # @contents = @post.contents

  end

  def new
    @content = FcContent.find_by(id: params[:id])
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.find_by(id: params[:id])
    # form_tagに@post.idを含ませて現在のfc.idを取得している
    @content = FcContent.new(content_body: params[:content_body],
                             user_id: current_user.id,
                             fc_id: params[:id])
    if @content.save
    # リダイレクトの後にpost.idがついたurlに戻る
    # redirect_to("/fc_contents/index/#{@post.id}")
      render("index")
    else
      render("index")
    end
  end

  private
    def content_params
      params.require(:content).permit(:content_content_body, :post_id, :user_id)
    end


    def fccontent_params
      params.require(:fc_content).permit(:content_body)
    end

end
