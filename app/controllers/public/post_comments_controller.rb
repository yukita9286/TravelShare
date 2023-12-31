class Public::PostCommentsController < ApplicationController

  def create
    post_image = PostImage.find(params[:post_image_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_image_id = post_image.id
    comment.save
    redirect_to request.referer
    # 非同期通信化
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
