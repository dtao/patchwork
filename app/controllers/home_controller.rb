class HomeController < ApplicationController
  def index
  end

  def login
    if request.post?
      user = User.find_by_email(params[:email])

      if user.nil?
        flash[:error] = "A user with that e-mail address doesn't exist."
        return redirect_to(login_path)
      end

      if !user.authenticate(params[:password])
        flash[:error] = "You've entered the wrong password."
        return redirect_to(login_path)
      end

      session[:user_id] = user.id

      flash[:notice] = "Welcome back, #{user.name}!"
      redirect_to(root_path)
    end
  end

  def register
    if request.post?
      user = User.create!(user_params)

      session[:user_id] = user.id

      flash[:notice] = "Thanks for joining, #{user.name}!"
      redirect_to(root_path)
    end
  end

  def logout
    session.delete(:user_id)

    flash[:notice] = "You've successfully logged out."
    redirect_to(root_path)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
