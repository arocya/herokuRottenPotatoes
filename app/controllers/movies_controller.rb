class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @all_ratings = ["G","PG","PG-13","R"]
    	


        #do this for sort also   
	#if params[:ratings]
	#@ratings = params[:ratings]
	#elsif session[:ratings]
	#@ratings = session[:ratings]
	#else
	#@all_ratings.each do |r|
	#(@ratings ||= {})[r] = 1
	#end
	#end
	
	
	@movie = Movie.order(params[:sort])      
	@movie = @movie.where(rating: params[:ratings].keys) if params[:ratings].present?

	

	#if params[:sort]=='Title'
	#	@movies.sort_by! {|movie| movie.title}
	#	@title_header = 'hilite'
	#else if params[:sort]=='Release Date'
	#	@movies.sort_by! {|movie| movie.release_date}
	#	@release_date_header = 'hilite'
	
	#end
	#end	

  end
	
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
