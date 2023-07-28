# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    begin
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil

      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )

      # puts "Webhook event received: #{event}"
    rescue JSON::ParserError => e
      # Invalid payload
      # puts "JSON::ParserError: #{e.message}"
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      # puts "Stripe::SignatureVerificationError: #{e.message}"
      status 400
      return
    rescue => e
      # puts "Error: #{e.message}"
      raise e
    end

    render json: { message: 'success' }
  end
end
