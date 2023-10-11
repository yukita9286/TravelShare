class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
    @customer = current_customer
  end
  
  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images
  end


  def edit
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
end
