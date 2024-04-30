class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
  
  def add_director
    @director_name = params.fetch("query_name")
    @director_dob = params.fetch("query_dob")
    @director_bio = params.fetch("query_bio")
    @director_image = params.fetch("query_image")
    x = Director.new
    x.name = @director_name
    x.dob = @director_dob
    x.bio = @director_bio
    x.image = @director_image
    x.save
    redirect_to("/directors")
  end

  def delete_director
    director_id = params.fetch("path_id").to_i
    director = Director.find(director_id)
    director.destroy
    redirect_to("/directors")
  end

  def modify_director
    @director_id = params.fetch("path_id").to_i
    @director_name = params.fetch("query_name")
    @director_dob = params.fetch("query_dob")
    @director_bio = params.fetch("query_bio")
    @director_image = params.fetch("query_image")
    x = Director.find(@director_id)
    x.name = @director_name
    x.dob = @director_dob
    x.bio = @director_bio
    x.image = @director_image
    x.save
    redirect_to("/directors/#{@director_id}")
  end
end
