class Admin::GenresController < ApplicationController
before_action :authenticate_admin!
  def index
  	@genre = Genre.new
  	@genres = Genre.all
  end

  def create
  	@genre = Genre.new(genre_params)
  	if @genre != nil
      @genre.save
  		redirect_to admin_genres_path
  	else
  		flash[:genre_created_error] = "ジャンル名を入力してください"
  	  render 'index'
  	end
  end

  def edit
  	@genre = Genre.find(params[:id])
  end

  def update
  	@genre = Genre.find(params[:id])
  	if @genre.update(genre_params)
  	  redirect_to admin_genres_path
  	  flash[:notice_update] = "ジャンル情報を編集しました！"
  	else
  	  render 'edit'
  	end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end
end
