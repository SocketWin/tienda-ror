module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    session[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    remember_token = User.encrypt(session[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    @current_user = nil
    session.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def signed_in_user
    store_location
    redirect_to signin_url, notice: "Identificate forastero!" unless signed_in?
  end

  def user_is_admin
    store_location
    redirect_to signin_url, notice: "Debes ser administrador!" unless current_user.admin
  end

end
