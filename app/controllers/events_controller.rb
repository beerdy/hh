class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_gallery, only: [:new, :edit, :update]
  before_action :check_auth

  # GET /events
  # GET /events.json

  def index
    #unless current_user.admin? then redirect_to root_path; return false; end
    
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    unless current_user.admin? then redirect_to root_path; return false; end

    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end
  
  def search
    if params[:tag]
      @events = Event.where(tag: /[#{params[:tag]}]{5,}/)
    else
      @events = Event.all
    end
  end
  # POST /events
  # POST /events.json
  def create
    unless current_user.admin? then redirect_to root_path; return false; end

    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    unless current_user.admin? then redirect_to root_path; return false; end

    event = Event.new(event_params)
    respond_to do |format|
      if @event.update( event_params.merge!({photos: event.photos}) )
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    unless current_user.admin? then redirect_to root_path; return false; end
    
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
    def set_gallery
      @gallery = Gallery.new
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :slave, :image, :link, :tag, :url, :link, :sort, :photos => [])
    end
end
