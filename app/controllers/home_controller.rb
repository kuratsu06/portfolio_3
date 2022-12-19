class HomeController < ApplicationController
  def top
    @posts = Post.status_public.order(created_at: :desc)
  end
end
