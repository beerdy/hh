class UsersController < ApplicationController
  include Bonuses
  before_action :get_bonuse
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    unless current_user.admin? then redirect_to root_path; return false; end

    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @bonuse = Bonuse.new()
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    #unless current_user.admin? then redirect_to root_path; return false; end
    card_status = ''

    respond_to do |format|
      unless is_card_current_user? 
        # Сбросить если введеная карта не принадлежит пользователю 
        params[:user][:card] = '' 
        card_status = "Указанная карта не принадлежит Вам. Оставте поле карты пустым или введите корректный номер"
      end if user_params[:card] != ''

      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Данные пользователя успешно обновленны. '+card_status }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def update_user
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    unless current_user.admin? then redirect_to root_path; return false; end

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:fio, :email, :phone, :card, :image, :role, :bonuses, :percent, :hb )
    end
end
