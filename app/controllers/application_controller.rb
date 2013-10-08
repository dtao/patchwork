class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  rescue_from ActiveRecord::ActiveRecordError, :with => :handle_active_record_error

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  private

  def handle_active_record_error(err)
    flash[:error] = get_error_message(err.record)

    # For POST requests, we can send the user back where they came from.
    if request.post?
      redirect_to(request.referrer)

    # Otherwise we'd better play it safe and send 'em back to the home page (to
    # avoid a redirect loop in case something went wrong with a GET request).
    else
      redirect_to('/')
    end
  end

  def get_error_message(record)
    record.errors.map { |attr, err| err }.join(' | ')
  end
end
