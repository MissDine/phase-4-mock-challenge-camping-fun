class CamperController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_camper_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_exception
  def index
    campers = Camper.all
    render json: campers
  end

  def show
    camper = Camper.find(params[:id])
    render json: camper, serializer: ShowCampersSerializer
  end

  def create
    new_camper = Camper.create!(camper_params)
    render json: new_camper, status: :created
  end

  private

  def render_camper_not_found
    render json: { error: "Camper not found" }, status: :not_found
  end

  def render_unprocessable_entity_exception(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def camper_params
    params.permit(:name, :age)
  end
end
