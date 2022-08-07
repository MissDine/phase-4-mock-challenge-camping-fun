class SignupController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_exception

  def create
    new_signup = Signup.create!(signup_params)
    render json: new_signup.activity, status: :created
  end

  private

  def signup_params
    params.permit(:time, :camper_id, :activity_id)
  end

  def render_unprocessable_entity_exception(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
