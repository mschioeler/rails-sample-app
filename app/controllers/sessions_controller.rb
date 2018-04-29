class SessionsController < ApplicationController
  def new
  end

  def destroy
  end

  def create
    mail = params[:session][:email]
    user = User.find_by_email mail.downcase
    if !user 
      flash.now[:danger] = "User #{mail} does not exist."
      render 'new'
    elsif !user.authenticate params[:session][:password]
      flash[:danger] = "Incorrect password for user #{mail}."
      render 'new'
    else
      log_in user
      redirect_to user
    end
  end
end
