class Api::V1::ClientProjectsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]
  before_action :set_client, only: [:index, :show, :create]

  def index
    @projects = @client.projects.order("created_at DESC")
    render json: {
      projects: ProjectSerializers::ProjectSerializer.new(@projects).serializable_hash
    }
  end

  def show
    @project = @client.projects.find(params[:id])
    @notes = @project.notes
    @log_hours = @project.log_hours
    render json: ProjectSerializers::ProjectDetailSerializer.new(@project).serializable_hash
  end

  def create
    @project = @client.projects.new(project_params)
    if @project.save
      render status: :ok, json: {
        project: ProjectSerializers::ProjectSerializer.new(@project).serializable_hash
      }
    else
      error = @project.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error  }
    end
  end

  def update
    if @project.update!(project_params)
      render json: {
        project: ProjectSerializers::ProjectSerializer.new(@project).serializable_hash
      }
    else
      render status: :unprocessable_entity, json: { notice: 'error while updating' }
    end
  end

  def destroy
    if @project.destroy
      head :no_content, status: :ok
    else
      render status: :unprocessable_entity, json: { notice: 'error while deleting' }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_client
    @client = Client.find(params[:client_id])
  end

  def project_params
    params.require(:project).permit(:project_type, :start_date, :submission_date, :project_status, :client_id)
  end
end
