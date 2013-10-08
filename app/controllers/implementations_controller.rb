class ImplementationsController < ApplicationController
  def show
    @implementation = Implementation.find(params[:id])
    @patch = @implementation.patch
  end

  def new
    @patch = Patch.find(params[:id])
    @implementation = @patch.implementations.new
  end

  def create
    redirect_to(Implementation.create!(implementation_params))
  end

  private

  def implementation_params
    params.require(:implementation).permit(:patch_id, :source).merge(:user => current_user)
  end
end
