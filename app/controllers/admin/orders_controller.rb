class Admin::OrdersController < ApplicationController

 before_action :authenticate_admin!

	def index

      if params[:customer_id]
		@orders= Order.where(customer_id: params[:customer_id])
	  else
		@orders = Order.all
      end
    end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end

	def total(items_total_price)

	end

	def update
		order = Order.find(params[:id])
		order_details = order.order_details
        order.update(order_params)

		if order.order_status == "入金確認"
			order_details.update_all(making_status: "製作待ち")
		end
		redirect_to admin_order_path(order.id)
	end

  private
	def order_params
		params.require(:order).permit(:order_status)
	end

end