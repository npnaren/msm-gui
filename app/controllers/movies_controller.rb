class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def add_movie
    @movie_title = params.fetch("query_title")
    @movie_year = params.fetch("query_year")
    @movie_description = params.fetch("query_description")
    @movie_image = params.fetch("query_image")
    @movie_duration = params.fetch("query_duration")
    @movie_director_id = params.fetch("query_director_id")
    x = Movie.new
    x.title = @movie_title
    x.year = @movie_year
    x.description = @movie_description
    x.duration = @movie_duration       
    if Director.where(id: @movie_director_id).exists?
      x.director_id = @movie_director_id
      x.save
    elsif @movie_director_id == 0  
      x.director_id = "Uh oh! We weren't able to find a director for this movie."
      x.save
    end
  
    redirect_to("/movies")
  end

  def delete_movie
    movie_id = params.fetch("path_id").to_i
    movie = Movie.find(movie_id)
    movie.destroy
    redirect_to("/movies")
  end

  def modify_movie
    @movie_id = params.fetch("path_id").to_i
    @movie_title = params.fetch("query_title")
    @movie_year = params.fetch("query_year")
    @movie_description = params.fetch("query_description")
    @movie_image = params.fetch("query_image")
    @movie_duration = params.fetch("query_duration")
    @movie_director_id = params.fetch("query_director_id")
    x = Movie.find(@movie_id)
    x.title = @movie_title
    x.year = @movie_year
    x.description = @movie_description
    x.duration = @movie_duration
    x.image = @movie_image
    x.director_id = 4027
    if Director.where(id: @movie_director_id).exists?
      x.director_id = @movie_director_id
      x.save
    elsif @movie_director_id == 0  
      x.director_id = "Uh oh! We weren't able to find a director for this movie."
      x.save
    end

    redirect_to("/movies/#{@movie_id}")
  end
end
