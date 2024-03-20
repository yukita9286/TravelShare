class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.page(params[:page], )
    @customer = current_customer
  end

  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images.page(params[:page])
  end


  def edit
  end


  def out
    @customer = Customer.find(params[:id])

    if @customer.guest_customer?　　　　　# ゲストユーザーは退会できなよう設定
      redirect_to admin_customers_path, notice: 'ゲストユーザーは退会できません。'
    else
      @customer.update(is_deleted: true) # または必要な更新処理を実行
      redirect_to admin_customers_path, notice: 'アカウントが停止しました'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
end
