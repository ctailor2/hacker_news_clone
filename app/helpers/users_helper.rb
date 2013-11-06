helpers do

  def current_user=(new_current_user)
    @current_user = new_current_user
    session[:username] = @current_user.username
  end

  def current_user
    if session[:username]
      @current_user ||= User.find_by_username(session[:username])
    end
  end

  def logged_in?
    !session[:username].nil?
  end

  def logout
    session.clear
  end

end
