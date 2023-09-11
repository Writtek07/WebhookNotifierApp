class WebhookNotifierJob
  include Sidekiq::Worker

  def perform(endpoint, response_data, secret_key)
    WebhookNotifier.notify(endpoint, response_data,secret_key)
  end
end
