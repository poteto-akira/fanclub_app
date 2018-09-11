class FcContentsController < ApplicationController
  def index
    # @enters = Enter.find_by(id: params[:id])
    @post = Post.find_by(id: params[:id])

    @contents = FcContent.all
  end

  def show
    @content = FcContent.find_by(id: params[:id])
    @post = @content.post
  end

  def new
    @content = FcContent.find_by(id: params[:id])
    @post = Post.find_by(id: params[:id])

  end

  def create
    @post = Post.find_by(id: params[:id])
    # form_tagに@post.idを含ませて現在のfc.idを取得している
    @content = FcContent.new(content_title: params[:content_title],
                             content_body: params[:content_body],
                             user_id: current_user.id,
                             fc_id: params[:id])
    @content.save
    # リダイレクトの後にpost.idがついたurlに戻る
    redirect_to("/fc_contents/index/#{@post.id}")
  end
end
