# frozen_string_literal: true

class PaymentsController < ApplicationController
  def create_checkout_session
    Stripe.api_key = Rails.env.production? ? ENV['STRIPE_SECRET_KEY'] : ENV['STRIPE_TEST_SECRET_KEY']

    amount_in_euros = params[:amount].to_i
    # puts "amount: #{amount}"

    if amount_in_euros <= 0
      flash[:alert] = 'Oups, petit problème technique, veuillez réessayer'
      redirect_to root_path
      return
    end

    # Convert amount in euros to cents
    amount_in_euros *= 100

    session = Stripe::Checkout::Session.create({
                                                 payment_method_types: ['card'],
                                                 line_items: [{
                                                   price_data: {
                                                     currency: 'eur',
                                                     product_data: {
                                                       name: 'Donation'
                                                     },
                                                     unit_amount: amount_in_euros
                                                   },
                                                   quantity: 1
                                                 }],
                                                 mode: 'payment',
                                                 success_url: root_url + '?payment=success',
                                                 cancel_url: root_url + '?payment=cancel'
                                               })

    redirect_to session.url, status: 303, allow_other_host: true
  end
end
