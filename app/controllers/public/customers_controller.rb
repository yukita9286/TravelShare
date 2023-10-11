class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images
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
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
end
