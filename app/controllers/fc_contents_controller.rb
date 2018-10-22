class FcContentsController < ApplicationController
  before_action :authenticate_user!

  def index
    # render :layout => "index.html.erb"
    @post = Post.find_by(id: params[:id])
    # ここでorderしてもダメだからfc_content.rbで書いている
    # @contents = FcContent.all.order(created_at: :desc)
    @content = FcContent.new
    # @contents = @post.content
    # @contents = FcContent.all
    # respond_to do |format|
    #       format.html # html形式でアクセスがあった場合は特に何もなし(@messages = Message.allして終わり）
    #       format.json { @new_content = FcContent.where('id > ?', params[:id]) } # json形式でアクセスがあった場合は、params[:message][:id]よりも大きいidがないかMessageから検索して、@new_messageに代入する
    #     end
    @user = User.find_by(id: params[:id])

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
                             post_id: params[:id],
                             username: current_user.name)
    respond_to do |format|
    if @content.save
    # saveの後にpost.idがついたurlに戻る
      # redirect_to("/fc_contents/index/#{@post.id}")
      # render("index")
      format.html
      format.js
    else
      format.js {render :index}
    end
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
