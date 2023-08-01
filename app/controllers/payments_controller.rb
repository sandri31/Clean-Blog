# frozen_string_literal: true

class PaymentsController < ApplicationController
  def create_checkout_session
    Stripe.api_key = Rails.env.production? ? ENV['STRIPE_SECRET_KEY'] : ENV['STRIPE_TEST_SECRET_KEY']

    if params[:price_id].present?
      line_items = [{
        price: params[:price_id],
        quantity: 1
      }]
    else
      line_items = [{
        price_data: {
          product_data: {
            name: 'Donation'
          },
          unit_amount: (params[:amount].to_i * 100),
          currency: 'eur'
        },
        quantity: 1
      }]
    end

    session = Stripe::Checkout::Session.create({
                                                 payment_method_types: ['card'],
                                                 line_items:,
                                                 mode: 'payment',
                                                 success_url: root_url + '?payment=success',
                                                 cancel_url: root_url + '?payment=cancel'
                                               })

    redirect_to session.url, status: 303, allow_other_host: true
  end
end
