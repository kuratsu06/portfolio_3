class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @complete = Complete.find(params[:complete_id])
    @like = @complete.likes.create(user_id: current_user.id)

    if @like.save
      redirect_to complete_path(@complete)
    else
      render "completes/show"
    end
  end

  def destroy
    @complete = Complete.find(params[:complete_id])
    @like = @complete.likes.find_by(user_id: current_user.id)

    @like.destroy
      redirect_to complete_path(@complete)
  end
end
