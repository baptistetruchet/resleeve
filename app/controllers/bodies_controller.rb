class BodiesController < ApplicationController
  before_action :set_body, only: [:show, :edit, :update, :destroy]

  def index
    @bodies = Body.all
  end

  def show
    # @reviews = @body.reviews.all
  end

  def new
    @body = Body.new
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
    params.require(:body).permit(:title, :price_per_day, :location, :sex, :description)
  end

  def set_body
    @body = Body.find(params[:id])
  end

end