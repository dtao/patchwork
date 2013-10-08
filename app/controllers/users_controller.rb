class UsersController < ApplicationController
  def index
    @users = User.order(:score => :desc).limit(25)
  end

  def show
    @user            = User.find(params[:id])
    @patches         = @user.patches.order(:id => :desc).limit(10)
    @implementations = @user.implementations.order(:score => :desc).limit(10)
  end
end
