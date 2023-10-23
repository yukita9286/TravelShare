class Admin::PostImagesController < ApplicationController

  def new

    @post_image = PostImage.new

  end

  def index
    @post_images = PostImage.page(params[:page], )
  end

  def show
    @post_image = PostImage.find(params[:id])
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    @post_image.update(post_image_params)
    redirect_to admin_post_image_path(@post_image.id)

  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to admin_post_images_path
  end

    # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :body)
  end
end
