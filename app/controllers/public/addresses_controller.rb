class Public::AddressesController < ApplicationController
	 before_action :authenticate_customer!

    # 配送先一覧/配送先登録画面
    def index
        @address = Address.new
        @addresses = current_customer.addresses
    end

    # 配送先登録ボタン
    def create
        @address = Address.new(address_params)
        @address.customer_id = current_customer.id
        if @address.save
            redirect_to addresses_path
            flash[:success] = "登録しました。"
        else
            @address = Address.new
            @addresses = current_customer.addresses
            render 'index'
        end
    end

    # 配送先を削除する
    def destroy
        address = Address.find(params[:id])
        address.destroy
        redirect_to addresses_path
    end

    # 配送先編集ボタン
    def edit
        @address = Address.find(params[:id])
    end

    # 配送先編集保存ボタン
    def update
        address = Address.find(params[:id])
        address.update(address_params)
        redirect_to addresses_path
    end

    private
    def address_params
        params.require(:address).permit(:customer_id, :name, :postal_code, :address)
    end
end
