class Api::V1::NotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  rescue_from StandardError, with: :render_standard_error
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_error

  # POST api/v1/notes
  def create
    note = current_user.notes.create!(note_params)

    render json: { message: "Note '#{note.uuid}' was successfully created." }, status: :created
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

  def render_standard_error(e)
    render json: { error: e.message }, status: :internal_server_error
  end

  def render_record_invalid_error(e)
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
