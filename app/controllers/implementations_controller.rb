class ImplementationsController < ApplicationController
  before_filter :require_login, :only => [:new, :create, :edit, :update, :vote, :comment]

  def show
    @implementation = Implementation.find(params[:id], :include => :comments)
    @patch = @implementation.patch

    @new_comment = Comment.new(:subject => @implementation)

    # The comments are already in memory, so we'll sort them using Ruby.
    @comments = @implementation.comments.sort_by_descending(&:created_at)
  end

  def new
    @patch = Patch.find(params[:id])
    @implementation = @patch.implementations.new
  end

  def create
    redirect_to(Implementation.create!(implementation_params))
  end

  def edit
    @implementation = Implementation.find(params[:id])
    @patch = @implementation.patch
  end

  def update
    implementation = Implementation.find(params[:id])
    implementation.update_attributes(implementation_params)
    redirect_to(implementation)
  end

  def vote
    impl = Implementation.find(params[:id])
    current_user.vote!(impl)
    render_message("You voted for #{impl.label}.", implementation_path(impl))
  end

  def comment
    impl = Implementation.find(params[:id])
    impl.comments.create!(comment_params)
    redirect_to(impl)
  end

  private

  def implementation_params
    params.require(:implementation).permit(:patch_id, :source).merge(:user => current_user)
  end

  def comment_params
    params.require(:comment).permit(:content).merge(:user => current_user)
  end
end
