class UsersController < ApplicationController
  def index
    @users = User.order(:score => :desc)
  end

  def show
    @user = User.find(params[:id])
    @specs = @user.specs.order(:name => :asc)
    @implementations = @user.implementations.order(:id => :desc)
  end
end
