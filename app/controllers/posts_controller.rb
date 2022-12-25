class PostsController < ApplicationController
  before_action :set_post, only: %i( show edit update destroy )
  before_action :move_to_signed_in, only: %i( index new edit create update destroy )

  # GET /posts or /posts.json
  def index
    if (params[:category_id])
      category = Post.find(params[:category_id])
      @posts = Post.where(user_id: current_user.id, category_id: category.id)
    else
      @posts = Post.where(user_id: current_user.id)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @categories = Category.where(user_id: current_user.id)
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.where(user_id: current_user.id)
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "リストを作成しました" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "リストを更新しました" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to list_path, notice: "リストを削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :category_id, :title, :memo, :image, :status)
    end

    def move_to_signed_in
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
