class ApplicationController < ActionController::Base
  protect_from_forgery

   # got these tips from
  # http://lyconic.com/blog/2010/08/03/dry-up-your-ajax-code-with-the-jquery-rest-plugin
  before_filter :correct_safari_and_ie_accept_headers
  after_filter :set_xhr_flash

  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied. Please sign in first."
    session[:return_to] = request.referer
    redirect_to new_user_session_path
  end

  def after_sign_in_path_for(resource)
    return session[:return_to] || request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def require_login
    unless current_user
      flash[:error] = "Access denied. Please sign in first."
      session[:return_to] = request.path
      redirect_to new_user_session_path
    end
  end

  def load_event
    @event = Event.find(params[:id])
  end

  def access_denied
    main_event = @main_event || @event.main_event || root_path
    flash[:error] = "Access Denied. (We require more vespene gas)"
    redirect_to main_event and return
  end

end
