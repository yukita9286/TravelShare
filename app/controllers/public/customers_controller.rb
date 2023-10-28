class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
   # ゲストを制限
  before_action :ensure_guest_customer, only: [:edit, :update, :confirm, :out, :liked_posts]
  
  def index
    
  end
  
  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images.page(params[:page])
  end

  def edit
     @customer = Customer.find(params[:id])
  end


  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(current_customer.id)
  end

  def confirm
  end

  def out
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def liked_posts
    @post_image = PostImage.new
    @liked_posts = PostImage.liked_posts(current_customer, params[:page], 5)
  end


  private

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to customer_path(current_customer), notice: "ゲストユーザーはアクセスできません"
   end
  end

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
end
