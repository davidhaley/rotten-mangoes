class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    if params[:runtime_in_minutes]
      range = params[:runtime_in_minutes]
      if range == "under_90_minutes"
        @movies = @movies.where('runtime_in_minutes < ?', "#{90}")
      elsif range == "between_90_and_120_minutes"
        @movies = @movies.where('runtime_in_minutes BETWEEN ? AND ?', "#{90}", "#{120}")
      elsif range == "greater_than_120_minutes"
        @movies = @movies.where('runtime_in_minutes > ?', "#{120}")
      end
      flash.now[:notice] = "There are no movies in the database based on your search criteria." if @movies.empty?
    end

    if params[:query]
      @movies = @movies.query(params[:query])
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  # A list of the param names that can be used for filtering the Movie list.
  def filtering_params(params)
    params.slice(:title, :director)
  end

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end
end