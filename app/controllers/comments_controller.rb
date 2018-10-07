class CommentsController < ApplicationController

def create
    # @content = FcContent.find(params[:post_id]) #①
    @comment = Comment.new(user_id: current_user.id,
                            content: params[:comment_content]) #②
    # 現在のuserのidを入れます。
    @comment.user_id = current_user.id #③
    if @comment.save
      # 保存がされると、render :indexによって「app/views/comments/index.js.erb」を探しにいきます。
      render :index #④
    end
  end

  def destroy
    @comment = Comment.find(params[:id]) #⑤
    if @comment.destroy
      render :index #⑥
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:comment_content,:user_id)
    end
end
