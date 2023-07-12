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

  def unsubscribe
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy

    redirect_to root_path, notice: 'Vous avez été désinscrit de la newsletter.'
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
