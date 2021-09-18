class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
  end

  def show
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to admin_genres_path
  end

  def edit
  end

  def update
  end
  
  def destroy
  end  

  private
  def admin_genre_params
    params.require(:genre).permit(:name)
  end
end
