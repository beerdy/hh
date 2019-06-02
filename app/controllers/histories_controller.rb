class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :check_auth
  
  # GET /histories
  # GET /histories.json
  def index
    unless current_user.admin? then redirect_to root_path; return false; end
    
    @histories = History.all
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
    unless current_user.admin? then redirect_to root_path; return false; end
  end

  # GET /histories/new
  def new
    unless current_user.admin? then redirect_to root_path; return false; end
    
    @history = History.new
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    unless current_user.admin? then redirect_to root_path; return false; end
    
    @history = History.new(history_params)

    respond_to do |format|
      if @history.save
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.json { render :show, status: :created, location: @history }
      else
        format.html { render :new }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    unless current_user.admin? then redirect_to root_path; return false; end
    
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    unless current_user.admin? then redirect_to root_path; return false; end
    
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:cardIdFrom, :cardIdTo, :sum, :time)
    end
end
