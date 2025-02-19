class NotesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_note, only: %i[edit update destroy]

  def index
    @notes = Note.includes(:user).order(updated_at: :desc).page(params[:page])
  end

  def show
    @note = Note.find_by!(uuid: params[:id])
  end

  def new
    @note = current_user.notes.new()
  end

  def create
    @note = current_user.notes.new(note_params)

    if @note.save
      redirect_to notes_path, notice: "Note was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @note.update(note_params)
      redirect_to note_path(@note), notice: "Note was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path, notice: "Note was successfully deleted."
  end

  private

  def set_note
    @note = current_user.notes.find_by!(uuid: params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end
end
