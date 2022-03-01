class Api::V1::NotesController < ApplicationController
  before_action :find_noteable, [:index, :show, :create]
  before_action :get_note, [:update, :destroy]

  def index
    @notes = @noteable.notes.order("created_at DESC")
    render json: {
      notes: NoteSerializer.new(@notes).serializable_hash
    }
  end

  def show
    @note = @noteable.notes.find(params[:id])
    if @note
      render json: {
        note: NoteSerializer.new(@note).serializable_hash
      }
    else
      render json: {
        status: 500,
        errors: ['notes not found']
      }
    end
  end

  def create
    @note = @noteable.notes.create(note_params)
    render json: {
      note: NoteSerializer.new(@note).serializable_hash
    }
  end

  def update
    if @note.update!(note_params)
      render json: {
        note: NoteSerializer.new(@note).serializable_hash
      }
    else
      render status: :unprocessable_entity, json: { notice: 'note not updated' }
    end
  end

  def destroy
    if @note.destroy!
      head :no_content, status: :ok
    else
      render status: :unprocessable_entity, json: { notice: 'note not deleted' }
    end
  end

  private

  def note_params
    params.require(:note).permit(:description)
  end

  def get_note
    @note = Note.find(params[:id])
  end

  def find_noteable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @noteable = $1.classify.constantize.find(value)
        return @noteable
      end
    end
    nil
  end
end
