class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :show, :destroy]

  def index
    @projects = Project.order("created_at DESC")
    render json: {
      projects: ProjectSerializers::ProjectSerializer.new(@projects).serializable_hash
    }
  end

  def show
    render json: ProjectSerializers::ProjectDetailSerializer.new(@project).serializable_hash.to_json
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render status: :ok, json: {
        project: ProjectSerializer.new(@project).serializable_hash
      }
    else
      error = @project.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error  }
    end
  end

  def update
    if @project.update!(project_params)
      render json: {
        project:ProjectSerializer.new(@project).serializable_hash.to_json
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

  def project_params
    params.require(:project).permit(:project_type, :start_date, :submission_date, :project_status, :client_id)
  end
end
