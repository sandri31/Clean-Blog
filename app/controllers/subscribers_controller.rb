# frozen_string_literal: true

class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      redirect_to root_path, notice: 'Merci pour votre inscription !'
    else
      redirect_to root_path, alert: 'Vous êtes déjà inscrit à la newsletter'
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
