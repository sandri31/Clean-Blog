# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.env.production? ? ENV['STRIPE_WEBHOOK_SECRET'] : ENV['STRIPE_TEST_WEBHOOK_SECRET']

    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      return head :bad_request
    end

    case event['type']
    when 'checkout.session.completed'
      session = event['data']['object']
    when 'payment_intent.succeeded'
      payment_intent = event['data']['object']
    end

    head :ok
  end
end
