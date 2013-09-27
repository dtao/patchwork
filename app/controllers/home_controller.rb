class HomeController < ApplicationController
  force_ssl :only => [:login, :register], :if => lambda { Rails.env.production? }

  def index
    if logged_in?
      @function = Function.new(:user => current_user)
      @functions = current_user.functions.order(:name => :asc)
      @implementations = current_user.implementations.order(:id => :desc)
    end
  end

  def register
    if request.post?
      user = User.create!(user_params)

      # Log the user in.
      session[:user_id] = user.id

      flash[:notice] = "Welcome, #{user.real_name}!"
      redirect_to(root_url(:protocol => 'http'))
    end
  end

  def login
    if request.post?
      user = User.find_by_user_name(params[:user_name])

      if user.nil?
        flash[:error] = 'That user name does not exist!'
        return redirect_to(login_path)
      end

      if !user.authenticate(params[:password])
        flash[:error] = 'You entered the wrong password.'
        return redirect_to(login_path)
      end

      # Log the user in.
      session[:user_id] = user.id

      flash[:notice] = "Welcome back, #{user.real_name}!"
      redirect_to(root_url(:protocol => 'http'))
    end
  end

  def logout
    # Log the user out.
    session.delete(:user_id)

    flash[:notice] = "You've successfully logged out."
    redirect_to(root_url(:protocol => 'http'))
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :real_name, :email, :password, :password_confirmation)
  end
end
