class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  rescue_from ActiveRecord::ActiveRecordError, :with => :handle_active_record_error

  def render_message(message, redirect_path=nil)
    if request.xhr?
      render(:json => { :status => 'success', :message => message })
    else
      flash[:notice] = message
      redirect_to(redirect_path || root_path)
    end
  end

  def render_error(message, redirect_path=nil)
    if request.xhr?
      render(:json => { :status => 'error', :message => message })
    else
      flash[:error] = message
      redirect_to(redirect_path || root_path)
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  private

  def handle_active_record_error(err)
    puts "Handing ActiveRecord::ActiveRecordError: #{err}"

    message = get_error_message(err)

    # For POST requests, we can send the user back where they came from.
    redirect_path = request.referrer

    if !request.post?
      # Otherwise we'd better play it safe and send 'em back to the home page
      # (to avoid a redirect loop in case something went wrong with a GET
      # request).
      redirect_path = root_path
    end

    render_error(message)
  end

  def get_error_message(error)
    return error.message unless error.respond_to?(:record)

    record.errors.map { |attr, err| err }.join(' | ')
  end
end
