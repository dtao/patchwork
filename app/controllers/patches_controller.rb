class PatchesController < ApplicationController
  def index
    @patches = Patch.order(:id => :desc)
  end

  def new
    @patch = Patch.new
  end

  def create
    redirect_to(Patch.create!(patch_params))
  end

  def show
    @patch = Patch.find(params[:id], :include => :implementations)
  end

  def edit
    @patch = Patch.find(params[:id])
  end

  def update
    @patch = Patch.find(params[:id])

    if @patch.user != current_user
      flash[:error] = "You aren't allowed to update other users' patches."
      return redirect_to(@patch)
    end

    @patch.update!(patch_params)

    redirect_to(@patch)
  end

  private

  def patch_params
    params.require(:patch).permit(:name, :language, :description, :tags, :tests).merge(:user => current_user)
  end
end
