require 'uri'
require 'net/http'
require 'net/https'
require 'json'

class BonusesController < ApplicationController
  include Bonuses
  before_action :get_bonuse
  
  before_action :set_bonuse, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def get
    #000807 - real number
    @toSend = {
      "cardId"=>"#{params[:card_id]}"
    }.to_json

    uri = URI.parse("http://79.111.122.45:88/front_bonuses/hs/bonuses/getSum")
    http = Net::HTTP.new(uri.host,uri.port)
    #https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = { 'Content-Type' => 'application/json' })
    req.basic_auth 'otklik1c', '123456'
    #req['foo'] = 'bar'
    req.body = "#{@toSend}"
    puts "#{req.body}"
    res = http.request(req)
    @some = "Response #{res.code} #{res.message}: #{res.body}"
  end

  # POST 
  def move
    if @card == params[:card]
      render json: { status: 'youcard' }, status: :accepted
    elsif @data_1C["bonusSum"] < params[:count].to_i
      render json: { status: 'notenough' }, status: :accepted
    else
      @toSend = {
        "cardIdFrom"=>@card,
        "cardIdTo"=>"#{params[:card]}",
        "sum"=>params[:count].to_i
      }.to_json

      uri = URI.parse("http://79.111.122.45:88/front_bonuses/hs/bonuses/moveSum")
      http = Net::HTTP.new(uri.host,uri.port)
      #https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      req.basic_auth 'otklik1c', '123456'
      #req['foo'] = 'bar'
      req.body = "#{@toSend}"
      res = http.request(req)
      # "Response #{res.code} #{res.message}: #{res.body}"
      if res.code.to_i == 200
        status = 'ok'
      else
        status = 'errorservice'
      end
      render json: { status: status }, status: :accepted
    end
  end

  def add
    #000807 - real number
    @toSend = {
      "cardId"=>"#{params[:card_id]}",
      "sum"=>params[:sum].to_i
    }.to_json

    uri = URI.parse("http://79.111.122.45:88/front_bonuses/hs/bonuses/addSum")
    http = Net::HTTP.new(uri.host,uri.port)
    #https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req.basic_auth 'otklik1c', '123456'
    #req['foo'] = 'bar'
    req.body = "#{@toSend}"
    puts "#{req.body}"
    res = http.request(req)
    @some = "Response #{res.code} #{res.message}: #{res.body}"    
  end

  def prize
    params[:bonuse] = params
    user_source = current_user
    user_distantion = User.where( card: bonuse_params[:card] ).first
    
    respond_to do |format|
      if user_source.bonuses < bonuse_params[:count].to_i # and user_source.card != bonuse_params[:card]
        #format.html { render :edit }
        format.json { render json: { error: 'Ошибка бонусной системы'}, status: :unprocessable_entity }
      else
        user_distantion.inc( bonuses: bonuse_params[:count].to_i)
        user_source.inc( bonuses: bonuse_params[:count].to_i*-1)

        #format.html { redirect_to current_user, notice: 'Bonuse was successfully prized' }
        format.json { render :show, status: :ok}
      end
    end
  end

  # GET /bonuses
  # GET /bonuses.json
  def index
    @bonuses = Bonuse.all
  end

  # GET /bonuses/1
  # GET /bonuses/1.json
  def show
  end

  # GET /bonuses/new
  def new
    @bonuse = Bonuse.new
  end

  # GET /bonuses/1/edit
  def edit
  end

  # POST /bonuses
  # POST /bonuses.json
  def create
    @bonuse = Bonuse.new(bonuse_params)

    respond_to do |format|
      if @bonuse.save
        format.html { redirect_to @bonuse, notice: 'Bonuse was successfully created.' }
        format.json { render :show, status: :created, location: @bonuse }
      else
        format.html { render :new }
        format.json { render json: @bonuse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bonuses/1
  # PATCH/PUT /bonuses/1.json
  def update
    respond_to do |format|
      if @bonuse.update(bonuse_params)
        format.html { redirect_to @bonuse, notice: 'Bonuse was successfully updated.' }
        format.json { render :show, status: :ok, location: @bonuse }
      else
        format.html { render :edit }
        format.json { render json: @bonuse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bonuses/1
  # DELETE /bonuses/1.json
  def destroy
    @bonuse.destroy
    respond_to do |format|
      format.html { redirect_to bonuses_url, notice: 'Bonuse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bonuse
      @bonuse = Bonuse.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def bonuse_params
      params.require(:bonuse).permit(:used_id, :fio, :birthday, :count, :card)
    end
end
