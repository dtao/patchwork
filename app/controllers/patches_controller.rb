require 'package'

class PatchesController < ApplicationController
  before_filter :require_login, :only => [:new, :create, :edit, :update]

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
    respond_to do |format|
      format.html do
        @patch = Patch.find(params[:id], :include => :implementations)

        # Implementations are already in memory at this point, so we'll do an
        # in-memory sort.
        @implementations = @patch.implementations.sort_by(&:score).reverse
      end

      format.js do
        @patch = Patch.find(params[:id])
        @implementations = @patch.implementations.order(:score => :desc).limit(1)
      end
    end
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
