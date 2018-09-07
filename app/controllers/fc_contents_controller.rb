class FcContentsController < ApplicationController
  def index
    # @enters = Enter.find_by(id: params[:id])
    @post = Post.find_by(id: params[:id])

    @contents = FcContent.all
  end

  def show
    @content = FcContent.find_by(id: params[:id])
  end

  def new
    @content = FcContent.find_by(id: params[:id])
    
  end

  def create
    # fc_idカラムも新しく入れる。fc_idは現在のpost.idにする
    @enter = Enter.find_by(id: params[:id])
    @content = FcContent.new(content_title: params[:content_title],
                             content_body: params[:content_body],
                             user_id: current_user.id,
                             fc_id: params[:id])
    @content.save
    # リダイレクトの後にpost.idがついたurlに戻りたい
    redirect_to(root_path)
  end
end



# t.text :content_title
# t.text :content_body
# t.integer :user_id
# t.integer :fc_id
# t.string :content_image
