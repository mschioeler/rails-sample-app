module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    # if there is a session (logged in since browser opened), use that
    if (user_id = session[:user_id])
      # lazy initialization, but if not null, @current user should match id
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      # Maybe the user logged in with remember my even though he did
      # not login this session. If so, we log him in using cookies.
      # This means that next check will authenticate him with the session.
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !!current_user
  end
end
