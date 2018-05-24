class BodiesController < ApplicationController
  before_action :set_body, only: [:show, :edit, :update, :destroy]

  def index
    @location = params[:location] if params[:location] && params[:location] != ""

    # @bodies = policy_scope(Body).order(created_at: :desc)
    # @bodies = @bodies.select { |b| b.location =~ /#{@location}/i } if @location
    if @location
      # sql_query = "bodies.location @@ :location"
      # @bodies = policy_scope(Body).where(sql_query, location: "%#{@location}%").order(created_at: :desc)
      @bodies = policy_scope(Body).near(@location)
    else
      @bodies = policy_scope(Body).order(created_at: :desc)
    end

    @bodies = @bodies.select { |b| b.user != current_user}

    @bodies = @bodies.select { |b| b.sex == params[:sex][0] } if params[:sex] && params[:sex][0] != "A"

    max_p = params[:price_per_day]
    @bodies = @bodies.select { |b| b.price_per_day <= max_p.to_i } if max_p && max_p != ""

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
