class Api::V1::DataEntriesController < ApplicationController  
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
      begin
        notify_third_party_apis(@data_entry)
        render json: @data_entry, status: :created, location: @data_entry
      rescue => e
        render json: e.message, status: :unprocessable_entity  
      end
    else
      render json: @data_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /data_entries/1
  def update
    if @data_entry.update(data_entry_params)
      begin
        notify_third_party_apis(@data_entry)
        render json: @data_entry
      rescue => e
        render json: e.message, status: :unprocessable_entity
      end
    else
      render json: @data_entry.errors, status: :unprocessable_entity
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
      params.require(:data_entry).permit(:name, :id)
    end


    def notify_third_party_apis(response_data)
      configured_endpoints = Rails.configuration.third_party_endpoints
      secret_key = Rails.application.credentials.dig(:secret_key_base)
      configured_endpoints.each do |endpoint|
        WebhookNotifier.notify(endpoint, response_data,secret_key)
      end
    end
end
