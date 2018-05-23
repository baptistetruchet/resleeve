class BodiesController < ApplicationController
  before_action :set_body, only: [:show, :edit, :update, :destroy]

  def index
    @location = params[:location]
    @bodies = if @location && @location != ""
      policy_scope(Body).where(location: @location.capitalize).order(created_at: :desc)
    else
      policy_scope(Body).order(created_at: :desc)
    end

    if params[:sex] && params[:sex] != ""
      @bodies = @bodies.select do |body|
        body.sex == params[:sex]
      end
    end

    if params[:price_per_day] && params[:price_per_day] != ""
      @bodies = @bodies.select do |body|
        body.price_per_day <= params[:price_per_day].to_i
      end
    end
    @markers = @bodies.select {|b| !b.latitude.nil? }.map do |body|
        {
          lat: body.latitude,
          lng: body.longitude,
          infoWindow: { content: render_to_string(partial: "/bodies/map_box", locals: { body: body }) }
        }
    end
  end

  def show
    # @reviews = @body.reviews.all
  end

  def new
    @body = Body.new
    authorize @body
  end

  def edit
  end

  def update
    @body.update(body_params)
    redirect_to root_path
  end

  def create
    @body = Body.new(body_params)
    @body.user = current_user
    authorize @body
    if @body.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @body.destroy
    redirect_to root_path
  end

  private

  def body_params
    # je n'ai pas mis le user id car on devrait le recuperer ailleurs?
    params.require(:body).permit(:title, :price_per_day, :location, :sex, :description, :photo)
  end

  def set_body
    @body = Body.find(params[:id])
    authorize @body
  end

end
