class Api::V1::LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :update, :destroy]

  def index
    @leads = Lead.order("created_at DESC")
    render json: {
      leads: LeadSerializers::LeadSerializer.new(@leads).serializable_hash
    }
  end

  def show
    render json: {
      lead: LeadSerializers::LeadDetailSerializer.new(@lead, include: [:notes]).serializable_hash,
    }
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.save
      render json: {
        lead: LeadSerializers::LeadSerializer.new(@lead).serializable_hash
      }
    else
      error = @lead.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error  }
    end
  end

  def update
    if @lead.update!(lead_params)
      render json: {
        lead: LeadSerializers::LeadSerializer.new(@lead).serializable_hash
      }
    else
      render status: :unprocessable_entity, json: { notice: 'lead not updated' }
    end
  end

  def destroy
    if @lead.destroy!
      head :no_content, status: :ok
    else
      render status: :unprocessable_entity, json: { notice: 'lead not deleted' }
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:title, :company_name, :company_address, :email_address, :phone_number)
  end

  def set_lead
    @lead = Lead.find(params[:id])
  end
end
