class ActivityController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_exception

  def index
    activities = Activity.all
    render json: activities, status: :ok
  end

  def destroy
    activity = Activity.find(params[:id])
    activity.destroy
    render json: {}, status: :ok
  end

  private

  def record_not_found_exception
    render json: {error: "Activity not found" }, status: :not_found
  end
end
