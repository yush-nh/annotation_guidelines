class Api::V1::NotesController < ActionController::API
  rescue_from StandardError, with: :render_standard_error
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_error

  # GEt api/v1/notes/:uuid
  def show
    note = Note.find_by!(uuid: params[:id])

    render json: { title: note.title, body: note.body }, status: :ok
  end

  # POST api/v1/notes
  def create
    note = current_user.notes.create!(note_params)

    render json: { message: "Note '#{note.uuid}' was successfully created." }, status: :created
  end

  # PUT api/v1/notes/:uuid
  def update
    current_note.update!(note_params)

    render json: { message: "Note '#{params[:id]}' was successfully updated." }, status: :ok
  end

  # DELETE api/v1/notes/:uuid
  def destroy
    current_note.destroy

    render json: { message: "Note '#{params[:id]}' was successfully deleted." }, status: :ok
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

  def current_note
    current_user.notes.find_by!(uuid: params[:id])
  end

  def render_standard_error(e)
    render json: { error: e.message }, status: :internal_server_error
  end

  def render_record_invalid_error(e)
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def render_record_not_found_error
    render json: { error: "Could not find the note with UUID '#{params[:id]}'" }, status: :not_found
  end
end
