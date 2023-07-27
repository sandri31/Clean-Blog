# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook)
      )
    rescue JSON::ParserError => e
      # Invalid payload
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      status 400
      return
    end

    # Handle the checkout.session.completed event
    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']

      Donation.create!(
        email: session['customer_details']['email'],
        amount: session['amount_total']
      )
    end

    render json: { message: 'success' }
  end
end
