class Api::V1::InvoicesController < ApplicationController
  before_action :set_invoice, only: [:update, :show, :destroy]
  before_action :set_project, only: [:index, :create]

  def index
    @invoices = @project.invoices.order("created_at DESC")
    render json: {
      invoices: InvoiceSerializers::InvoiceSerializer.new(@invoices).serializable_hash
    }
  end

  def show
    render status: :ok, json: {
      invoice: InvoiceSerializers::InvoiceDetailSerializer.new(@invoice).serializable_hash
    }
  end

  def create
    @invoice = @project.invoices.new(invoice_params)
    if @invoice.save
      render json: {
        invoice: InvoiceSerializers::InvoiceSerializers::InvoiceSerializer.new(@invoice).serializable_hash
      }
    else
      error = @invoice.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error  }
    end
  end

  def update
    if @invoice.update!(invoice_params)
      render json: {
        invoice: InvoiceSerializers::InvoiceSerializer.new(@invoice).serializable_hash
      }
    else
      render status: :unprocessable_entity, json: { notice: 'invoice not updated' }
    end
  end

  def destroy
    if @invoice.destroy
      head :no_content, status: :ok
    else
      render status: :unprocessable_entity, json: { notice: 'invoice not deleted' }
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def invoice_params
    params.require(:invoice).permit(:invoice_item, :total_amount, :invoice_type, :project_id)
  end
end