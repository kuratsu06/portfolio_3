class CompletesController < ApplicationController
  before_action :set_complete, only: %i[ show edit update destroy ]

  # GET /completes or /completes.json
  def index
    @completes = Complete.all
  end

  # GET /completes/1 or /completes/1.json
  def show
  end

  # GET /completes/new
  def new
    @complete = Complete.new
  end

  # GET /completes/1/edit
  def edit
  end

  # POST /completes or /completes.json
  def create
    @complete = Complete.new(complete_params)

    respond_to do |format|
      if @complete.save
        format.html { redirect_to complete_url(@complete), notice: "Complete was successfully created." }
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
        format.html { redirect_to complete_url(@complete), notice: "Complete was successfully updated." }
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
      format.html { redirect_to completes_url, notice: "Complete was successfully destroyed." }
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
end
