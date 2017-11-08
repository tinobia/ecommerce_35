module SessionsHelper
  def log_in user
    session[:user_id] = user.id
    set_cart_id
  end

  def current_user? user
    user == current_user
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def set_cart_id
    @cart = current_user.orders.find_by status: "in_progress"
    session[:cart_id] = @cart.id if @cart.present?
  end
end
