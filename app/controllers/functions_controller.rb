class FunctionsController < ApplicationController
  def index
    @functions = Function.order(:id => :desc)
  end

  def new
    @function = Function.new
  end

  def create
    function = Function.create!(function_params)

    flash[:notice] = "Successfully created function for '#{function.name}'"

    redirect_to(root_path)
  end

  def show
    @function = Function.find(params[:id])
    @implementations = @function.implementations.order(:score => :desc)
    @implementation = Implementation.new(:function => @function, :source => @function.signature)
    @comments = @function.comments.order(:id => :asc)
  end

  def comment
    function = Function.find(params[:id])
    function.comments.create!(comment_params)
    redirect_to(function)
  end

  private

  def function_params
    params.require(:function).permit(:signature, :name, :description, :tests).merge(:user => current_user)
  end

  def comment_params
    params.require(:comment).permit(:content).merge(:user => current_user)
  end
end
