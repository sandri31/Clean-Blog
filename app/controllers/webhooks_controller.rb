# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.env.production? ? ENV['STRIPE_WEBHOOK_SECRET'] : ENV['STRIPE_TEST_WEBHOOK_SECRET']

    event = nil

    # Vérifiez la signature du webhook pour vous assurer qu'il provient réellement de Stripe
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # En cas d'erreur de parsing JSON, vous devriez renvoyer une erreur 400
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      # En cas d'erreur de vérification de signature, vous devriez renvoyer une erreur 400
      return head :bad_request
    end

    # Traitez l'événement webhook
    case event['type']
    when 'checkout.session.completed'
      session = event['data']['object']

      # Effectuez des actions basées sur le succès de la session de paiement

    when 'payment_intent.succeeded'
      payment_intent = event['data']['object']

      # Effectuez des actions basées sur le succès de l'intention de paiement

      # Vous pouvez ajouter des cas pour d'autres types d'événements ici
    end

    # Renvoyez un statut 200 pour indiquer à Stripe que le webhook a été reçu correctement
    head :ok
  end
end
