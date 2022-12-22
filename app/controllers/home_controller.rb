class HomeController < ApplicationController
  before_action :move_to_signed_in, only: %i[ like list ]

  def top
    @posts = Post.status_public.order(created_at: :desc)
    @completes = Complete.status_public.order(created_at: :desc)
    @all_posts = @posts + @completes
  end

  def like
    @likes = Like.where(user_id: current_user.id)
  end

  def list
    @categories = Category.where(user_id: current_user.id)
    @categories_count = Category.where(user_id: current_user.id).count
    @posts = Post.where(user_id: current_user.id)
    @post = Post.find_by(params[:post_id])
    @posts_count = Post.where(user_id: current_user.id).count
    @completes = Complete.where(user_id: current_user.id)
    @complete = Complete.find_by(params[:complete_id])
    @completes_count = Complete.where(user_id: current_user.id).count
  end

  private
    def move_to_signed_in
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
