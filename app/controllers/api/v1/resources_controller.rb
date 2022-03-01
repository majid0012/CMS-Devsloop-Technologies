class Api::V1::ResourcesController < ApplicationController
  before_action :get_resource, only: [:show, :update, :destroy]

  def index
    @resources = Resource.order("created_at DESC")
    render json: {
      resources: ResourceSerializers::ResourceSerializer.new(@resources).serializable_hash
    } 
  end

  def show
    render json: {
      resource: ResourceSerializers::ResourceDetailSerializer.new(@resource).serializable_hash
    }
  end

  def create
    @resource = Resource.new(resource_params)
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
end
