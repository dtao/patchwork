class ImplementationsController < ApplicationController
  def new
    @spec = Spec.find(params[:id])
    @implementation = Implementation.new(:spec => @spec, :source => @spec.signature)
  end

  def create
    implementation = Implementation.create!(implementation_params)

    flash[:notice] = "Successfully saved implementation for '#{implementation.spec.name}'"

    redirect_to(implementation)
  end

  def show
    @implementation = Implementation.find(params[:id])
    @comments = @implementation.comments.order(:id => :asc)
  end

  def vote
    implementation = Implementation.find(params[:id])

    if !logged_in?
      flash[:error] = "You must log in to vote."
      return redirect_to(implementation)
    end

    if implementation.user == current_user
      flash[:error] = "You can't vote on your own implementation!"
      return redirect_to(implementation)
    end

    if implementation.votes.where(:user => current_user).any?
      flash[:error] = "You've already voted for this implementation."
      return redirect_to(implementation)
    end

    implementation.votes.create!(:user => current_user)
    redirect_to(implementation)
  end

  def comment
    implementation = Implementation.find(params[:id])
    implementation.comments.create!(comment_params)
    redirect_to(implementation)
  end

  private

  def implementation_params
    params.require(:implementation).permit(:spec_id, :source, :name, :description).merge(:user => current_user)
  end

  def comment_params
    params.require(:comment).permit(:content).merge(:user => current_user)
  end
end
