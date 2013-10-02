class FunctionsController < ApplicationController
  def index
    @languages = Function.group(:language).count
  end

  def by_language
    @language = params[:language]
    @functions = Function.where(:language => params[:language]).order(:id => :desc)
  end

  def new
    @function = Function.new(:language => params[:language])
  end

  def create
    function = Function.create!(function_params)

    flash[:notice] = "Successfully created function for '#{function.name}'"

    redirect_to(root_path)
  end

  def show
    @function = Function.find(params[:id])
    @implementations = @function.implementations.order(:score => :desc)
    @implementation = Implementation.new(:function => @function)
    @comments = @function.comments.order(:id => :asc)
  end

  def comment
    function = Function.find(params[:id])
    function.comments.create!(comment_params)
    redirect_to(function)
  end

  private

  def function_params
    params.require(:function).permit(:name, :description, :tests).merge(:user => current_user)
  end

  def comment_params
    params.require(:comment).permit(:content).merge(:user => current_user)
  end
end
