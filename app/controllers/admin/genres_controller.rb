class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def show
  end

  def create
    genre = Genre.new(admin_genre_params)
    genre.save
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    genre.update(admin_genre_params)
    redirect_to admin_genres_path, notice: 'Genre was successfully updated.'
  end

  def destroy
  end

  private
  def admin_genre_params
    params.require(:genre).permit(:name)
  end
end
