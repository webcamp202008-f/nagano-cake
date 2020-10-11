class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
   @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
      flash[:notice_update] = "ジャンル情報を更新しました！"
    else
      edit_admin_customer_path(@customer)
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :address, :phone_number, :email, :is_active)
  end
end


