class SpecsController < ApplicationController
  def index
    @specs = Spec.order(:id => :desc)
  end

  def new
    @spec = Spec.new
  end

  def create
    spec = Spec.create!(spec_params)

    flash[:notice] = "Successfully created spec for '#{spec.name}'"

    redirect_to(root_path)
  end

  def show
    @spec = Spec.find(params[:id])
    @implementations = @spec.implementations.order(:score => :desc)
    @implementation = Implementation.new(:spec => @spec, :source => @spec.signature)
    @comments = @spec.comments.order(:id => :asc)
  end

  def comment
    spec = Spec.find(params[:id])
    spec.comments.create!(comment_params)
    redirect_to(spec)
  end

  private

  def spec_params
    params.require(:spec).permit(:signature, :name, :description, :tests).merge(:user => current_user)
  end

  def comment_params
    params.require(:comment).permit(:content).merge(:user => current_user)
  end
end
