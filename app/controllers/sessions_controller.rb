class SessionsController < ApplicationController
  def new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def create
    mail = params[:session][:email]
    @user = User.find_by_email mail.downcase
    if !@user 
      flash.now[:danger] = "User #{mail} does not exist."
      render 'new'
    elsif !@user.authenticate params[:session][:password]
      flash.now[:danger] = "Incorrect password for user #{mail}."
      render 'new'
    else
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    end
  end
end
