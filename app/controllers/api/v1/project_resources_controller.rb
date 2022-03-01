class Api::V1::ProjectResourcesController < ApplicationController
  before_action :set_resource, only: [:update, :destroy]
  before_action :set_project, only: [:index, :show, :create]

  def index
    @resources = @project.resources.order("created_at DESC")
    render json: {
      resources: ResourceSerializers::ResourceSerializer.new(@resources).serializable_hash
    } 
  end

  def show
    @resource = @project.resources.find(params[:id])
    render json: {
      resource: ResourceSerializers::ResourceDetailSerializer.new(@resource, include: [:notes, :projects]).serializable_hash
    }
  end

  def create
    @resource = @project.resources.new(resource_params)
    if @resource.save
      render status: :ok, json: {
        resource: ResourceSerializers::ResourceSerializer.new(@resource).serializable_hash
      }
    else
      error = @resource.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error  }
    end
  end

  def update
    if @resource.update!(resource_params)
      render json: {
        resource: ResourceSerializers::ResourceSerializer.new(@resource).serializable_hash.to_json
      }
    else
      render status: :unprocessable_entity, json: { notice: 'error while updating' }
    end
  end

  def destroy
    if @resource.destroy!
      head :no_content, status: :ok
    else
      render status: :unprocessable_entity, json: { notice: 'error while deleting' }
    end
  end

  private

  def resource_params
    params.require(:Resource).permit(:name, :designation, :salary, :email_address, :phone_number)
  end

  def get_resource
    @resource = Resource.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
