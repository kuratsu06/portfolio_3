class HomeController < ApplicationController
  def top
    @posts = Post.status_public.order(created_at: :desc)
  end

  def like
    @likes = Like.where(user_id: current_user.id)
  end
end
