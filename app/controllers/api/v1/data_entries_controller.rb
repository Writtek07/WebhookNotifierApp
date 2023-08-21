class Api::V1::DataEntriesController < ApplicationController
  before_action :verify_webhook_authenticity, only: [:create, :update]
  before_action :set_data_entry, only: %i[ show update destroy ]


  # GET /data_entries
  def index
    @data_entries = DataEntry.all

    render json: @data_entries
  end

  # GET /data_entries/1
  def show
    render json: @data_entry
  end

  # POST /data_entries
  def create
    @data_entry = DataEntry.new(data_entry_params)

    if @data_entry.save
      notify_third_party_apis(@data_entry)
      render json: @data_entry, status: :created, location: @data_entry, { message: 'Data entry created successfully' }
    else
      render json: @data_entry.errors, status: :unprocessable_entity, { errors: data_entry.errors.full_messages }
    end
  end

  # PATCH/PUT /data_entries/1
  def update
    if @data_entry.update(data_entry_params)
      notify_third_party_apis(@data_entry)
      render json: @data_entry, { message: 'Data entry created updated' }
    else
      render json: @data_entry.errors, status: :unprocessable_entity, { errors: data_entry.errors.full_messages }
    end
  end

  # DELETE /data_entries/1
  def destroy
    @data_entry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_entry
      @data_entry = DataEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def data_entry_params
      params.require(:data_entry).permit(:name)
    end

    def verify_webhook_authenticity
      secret_key = request.headers['X-Webhook-Secret-Key']
      unless secret_key == Rails.application.credentials.webhook_secret_key
        render json: { error: 'Invalid webhook authenticity token!' }, status: :unauthorized
      end
    end


    def notify_third_party_apis(response_data)
      configured_endpoints = Rails.configuration.third_party_endpoints
      configured_endpoints.each do |endpoint|
        WebhookNotifier.notify(endpoint, response_data)
      end
    end
end
