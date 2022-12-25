class CompletesController < ApplicationController
  before_action :set_complete, only: %i[ show edit update destroy ]
  before_action :move_to_signed_in, only: %i[ index new  edit create update destroy ]

  # GET /completes or /completes.json
  def index
    @completes = Complete.where(user_id: current_user.id)
  end

  # GET /completes/1 or /completes/1.json
  def show
    @like = Like.new
    @likes_count = Like.where(complete_id: @complete.id).count
    @comment = Comment.new
    @comments_count = Comment.where(complete_id: @complete.id).count
  end

  # GET /completes/new
  def new
    @post = Post.find(params[:post_id])
    @posts = Post.where(user_id: current_user.id)
    @complete = Complete.new
  end

  # GET /completes/1/edit
  def edit
    @post = @complete.post
    @posts = Post.where(user_id: current_user.id)
  end

  # POST /completes or /completes.json
  def create
    @complete = Complete.new(complete_params)
    @post = @complete.post

    respond_to do |format|
      if @complete.save
        format.html { redirect_to complete_url(@complete), notice: "リストを達成しました" }
        format.json { render :show, status: :created, location: @complete }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @complete.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /completes/1 or /completes/1.json
  def update
    respond_to do |format|
      if @complete.update(complete_params)
        format.html { redirect_to complete_url(@complete), notice: "達成したリストを更新しました" }
        format.json { render :show, status: :ok, location: @complete }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @complete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /completes/1 or /completes/1.json
  def destroy
    @complete.destroy

    respond_to do |format|
      format.html { redirect_to list_path, notice: "達成したリストを削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complete
      @complete = Complete.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def complete_params
      params.require(:complete).permit(:user_id, :post_id, :done, :memo, :image, :again, :status)
    end

    def move_to_signed_in
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
