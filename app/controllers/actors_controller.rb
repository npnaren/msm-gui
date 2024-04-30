class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
  def add_actor
    @actor_name = params.fetch("query_name")
    @actor_dob = params.fetch("query_dob")
    @actor_bio = params.fetch("query_bio")
    @actor_image = params.fetch("query_image")
    x = Actor.new
    x.name = @actor_name
    x.dob = @actor_dob
    x.bio = @actor_bio
    x.image = @actor_image
    x.save
    redirect_to("/actors")
  end

  def delete_actor
    actor_id = params.fetch("path_id").to_i
    actor = Actor.find(actor_id)
    actor.destroy
    redirect_to("/actors")
  end

  def modify_actor
    @actor_id = params.fetch("path_id").to_i
    @actor_name = params.fetch("query_name")
    @actor_dob = params.fetch("query_dob")
    @actor_bio = params.fetch("query_bio")
    @actor_image = params.fetch("query_image")
    x = Actor.find(@actor_id)
    x.name = @actor_name
    x.dob = @actor_dob
    x.bio = @actor_bio
    x.image = @actor_image
    x.save
    redirect_to("/actors/#{@actor_id}")
  end
end
