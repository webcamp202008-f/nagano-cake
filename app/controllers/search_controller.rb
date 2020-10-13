class SearchController < ApplicationController
  def search
  	word = params[:word]
    @range = params[:range]
    search = params[:search]

	 if @range == 'item'
	   @item = Item.search(word,search)
	 else
	   @customer = Customer.search(word,search)
	 end
  end
end

