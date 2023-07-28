# frozen_string_literal: true

class PaymentsController < ApplicationController
  def create_checkout_session
    Stripe.api_key = Rails.env.production? ? ENV['STRIPE_SECRET_KEY'] : ENV['STRIPE_TEST_SECRET_KEY']

    amount = params[:amount].to_i
    # puts "amount: #{amount}"

    if amount <= 0
      flash[:alert] = 'Oups, petit problème technique, veuillez réessayer'
      redirect_to root_path
      return
    end

    session = Stripe::Checkout::Session.create({
                                                 payment_method_types: ['card'],
                                                 line_items: [{
                                                   price_data: {
                                                     currency: 'eur',
                                                     product_data: {
                                                       name: 'Donation'
                                                     },
                                                     unit_amount: amount
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
