class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user["username"] = params["username"]
    @user["email"] = params["email"]
    # Check if email already exists
    if User.find_by("email" => params["email"])
      flash[:notice] = "Email already exists. Please use a different email."
      redirect_to "/users/new"
    else
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save
      flash[:notice] = "Thanks for signing up. Now login."
      redirect_to "/login"
    end
  end
end
