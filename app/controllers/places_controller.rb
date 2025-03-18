class PlacesController < ApplicationController

  def index
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @places = Place.where({ "user_id" => @user["id"] })
    else
      flash["notice"] = "Login first."
      redirect_to "/login"
    end
  end

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.find_by({ "id" => params["id"] })
      @entries = Entry.where({ 
        "place_id" => @place["id"],
        "user_id" => @user["id"] 
      })
    else
      flash["notice"] = "Login first."
      redirect_to "/login"
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.new
      @place["name"] = params["name"]
      @place["user_id"] = session["user_id"]
      @place.save
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/places"
  end

end
