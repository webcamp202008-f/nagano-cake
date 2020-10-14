class Public::OrdersController < ApplicationController

	before_action :authenticate_customer!

	def new
		@order = Order.new
		@customer = current_customer
		@addresses = Address.where(customer_id: current_customer.id)
	end

	def create
		customer = current_customer

		# sessionを使ってデータを一時保存
		session[:order] = Order.new

		cart_items = current_customer.cart_items

		# total_paymentのための計算
		sum = 0
		cart_items.each do |cart_item|
			sum += (cart_item.item.price.to_i * 1.1).floor * cart_item.quantity.to_i
		end

		session[:order][:deliver_fee] = 800
		session[:order][:total_payment] = sum + session[:order][:deliver_fee]
		session[:order][:order_status] = 0
		session[:order][:customer_id] = current_customer.id
		# ラジオボタンで選択された支払方法のenum番号を渡している
		session[:order][:how_to_pay] = params[:method].to_i

		# ラジオボタンで選択されたお届け先によって条件分岐
		destination = params[:a_method].to_i

		# ご自身の住所が選択された時
		if destination == 0

			session[:order][:post_code] = customer.post_code
			session[:order][:address] = customer.address
			session[:order][:addressee] = customer.family_name + customer.first_name

		# 登録済住所が選択された時
		elsif destination == 1

			address = Address.find(params[:address_for_order])
			session[:order][:post_code] = address.postal_code
			session[:order][:address] = address.address
			session[:order][:addressee] = address.name


		# 新しいお届け先が選択された時
		elsif destination == 2

			session[:new_address] = 2
			session[:order][:post_code] = params[:post_code]
			session[:order][:address] = params[:address]
			session[:order][:addressee] = params[:name]
		end


		if session[:order][:post_code].presence && session[:order][:address].presence && session[:order][:name].presence
			redirect_to new_order_path
		else
			redirect_to orders_confirm_path
		end


	end


	def confirm
		 @cart_items = current_customer.cart_items
	end


	def complete
		order = Order.new(session[:order])
		order.save

			if session[:new_address]
			address = current_customer.addresses.new
			address.postal_code = order.post_code
			address.address = order.address
			address.name = order.addressee
			address.save
			session[:new_address] = nil
		end

		# 以下、order_detail作成
		cart_items = current_customer.cart_items
		cart_items.each do |cart_item|
			order_detail = OrderDetail.new
			order_detail.order_id = order.id
			order_detail.item_id = cart_item.item.id
			order_detail.amount = cart_item.quantity
			order_detail.making_status = 0
			order_detail.order_price = (cart_item.item.price * 1.1).floor
			order_detail.save
		end

		# 購入後はカート内商品削除
		cart_items.destroy_all
	end

	def index
		@orders = current_customer.orders
	end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end
end

	# private
		# def shipping_address_params
		# 	params.require(:shipping_address).permit(:customer_id, :postal_code, :name, :address)

	#     def order_params
	#        params.require(:order).permit(:customer_id, :postage, :total_payment, :payment_method, :ordr_status, :post_code, :address, :name)
	#     end


	#     def order_detail_params
	#        params.require(:order_detail).permit(:order_id, :item_id, :quantity, :making_status, :price)
	#     end


