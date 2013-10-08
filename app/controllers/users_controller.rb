class UsersController < ApplicationController
  def index
    @users = User.order(:score => :desc).limit(25)
  end
end
