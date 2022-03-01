class Api::V1::ClientsController < ApplicationController
  before_action :load_client, only: [:show, :update, :destroy]

  def index
    @clients = Client.order("created_at DESC")
    render json: {
      clients: ClientSerializers::ClientSerializer.new(@clients).serializable_hash
    }
  end

  def show
    render json: {
      client: ClientSerializers::ClientDetailSerializer.new(@client, include: [:notes, :projects]).serializable_hash
    }
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      render status: :ok, json: {
        client: ClientSerializers::ClientSerializer.new(@client).serializable_hash
      }
    else
      error = @client.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error  }
    end
  end

  def update
    if @client.update!(client_params)
      render json: {
        client: ClientSerializers::ClientSerializer.new(@client).serializable_hash
      }
    else
      render status: :unprocessable_entity, json: { notice: 'error while updating' }
    end
  end

  def destroy
    if @client.destroy!
      head :no_content, status: :ok
    else
      render status: :unprocessable_entity, json: { notice: 'error while deleting' }
    end
  end

  private
  def client_params
    params.require(:client).permit(:name, :email_address)
  end

  def load_client
    @client = Client.find(params[:id])
  end
end
