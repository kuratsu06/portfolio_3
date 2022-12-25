class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ edit update destroy ]
  before_action :move_to_signed_in

  # GET /categories/new
  def new
    @categories = Category.where(user_id: current_user.id)
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @categories = Category.where(user_id: current_user.id)
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to new_post_path, notice: "カテゴリを作成しました" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to new_post_path, notice: "カテゴリを更新しました" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to list_path, notice: "カテゴリを削除しました" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:user_id, :name)
    end

    def move_to_signed_in
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
