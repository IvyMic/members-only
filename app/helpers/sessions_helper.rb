module SessionsHelper

  def log_in(user)
    the_remember_token = user.remember_token
    cookies.permanent[:the_remember_token] = the_remember_token
    user.update_attribute(:remember_token, User.digest(the_remember_token))
    self.current_user = user
  end

  def current_user
    the_remember_token = User.digest(cookies[:the_remember_token])
    user = @current_user ||= User.find_by(remember_token: the_remember_token)
    return nil unless user
    user
  end

  def current_user=(user)
    @current_user = user
  end

  def log_out
    current_user.update_attribute(:remember_token, current_user.create_token_for_user)

    cookies.delete(:the_remember_token)
    self.current_user = nil
  end

end
