class Public::PostImagesController < ApplicationController
  # ゲストを制限
  before_action :ensure_guest_customer, only: [:new, :create, :edit, :update, :destroy]

  def new

    @post_image = PostImage.new

  end

  # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.customer_id = current_customer.id
    if @post_image.save
      redirect_to post_image_path(@post_image), notice: "投稿しました"
    else
      @post_images = PostImage.page(params[:page], )
      render 'new'
    end
  end

  def index
    @post_image = PostImage.new
    @post_images = PostImage.page(params[:page], )
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    @post_image.update(post_image_params)
    redirect_to post_image_path(@post_image.id)

  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to post_images_path
  end

    # 投稿データのストロングパラメータ
  private

  def ensure_guest_customer
    if current_customer.guest_customer?
      redirect_to customer_path(current_customer), notice: "ゲストユーザーはプロフィール編集できません。"
    end
  end



  def post_image_params
    params.require(:post_image).permit(:title, :image, :body)
  end
end