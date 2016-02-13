class SessionsController < ApplicationController
  def new
  end

  def create
    #search database for user with specified email
    user = User.find_by(email: params[:session][:email].downcase)
    #verify user isn't nil and that password in params hash matches given password
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    #logs out, methods in sessions_helper.rb
    destroy_session(current_user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end

end
