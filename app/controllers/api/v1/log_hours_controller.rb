class Api::V1::LogHoursController < ApplicationController
  before_action :set_log_hour, only: [:update, :destroy]
  before_action :set_project, only: [:index, :show, :create]

  def index
    @log_hours = @project.log_hours.order("created_at DESC")
    render json: {
      log_hours: LogHourSerializer.new(@log_hours).serializable_hash
    }
  end

  def show
    @log_hour = @project.log_hours.find(params[:id])
    @notes = @log_hour.notes
    render status: :ok, json: {
      log_hour: LogHourSerializer.new(@log_hour).serializable_hash,
      notes: NoteSerializer.new(@notes).serializable_hash,
    }
  end

  def create
    @log_hour = @project.log_hours.new(log_hour_params)
    if @log_hour.save
      render json: {
        log_hour: LogHourSerializer.new(@log_hour).serializable_hash
      }
    else
      error = @log_hour.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error  }
    end
  end

  def update
    if @log_hour.update!(log_hour_params)
      render json: {
        log_hour: LogHourSerializer.new(@log_hour).serializable_hash
      }
    else
      render status: :unprocessable_entity, json: { notice: 'log_hour not updated' }
    end
  end

  def destroy
    if @log_hour.destroy
      head :no_content, status: :ok
    else
      render status: :unprocessable_entity, json: { notice: 'log_hour not deleted' }
    end
  end

  private

  def set_log_hour
    @log_hour = LogHour.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def log_hour_params
    params.require(:log_hour).permit(:date, :time_spent, :work_description, :project_id)
  end
end
