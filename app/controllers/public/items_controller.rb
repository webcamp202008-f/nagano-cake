class Public::ItemsController < ApplicationController

	def index
		@genres = Genre.all
		@items = Item.all
		@items_all = Item.all

	end

	def show
		@item = Item.find(params[:id])
		@cart_item = CartItem.new
		@genres = Genre.all
	end

	def top
		@genres = Genre.all
	    @items = Item.where(is_active: false)
    end

end

