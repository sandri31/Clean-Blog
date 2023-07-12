# frozen_string_literal: true

class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.token = SecureRandom.urlsafe_base64 # Generate a random token

    if @subscriber.save
      @article = Article.where(publicly_published: true).order(created_at: :desc).first
      NewsletterMailer.welcome_email(@subscriber, @article).deliver_now
      redirect_to root_path, notice: 'Merci pour votre inscription à la newsletter.'
    else
      redirect_to root_path, alert: 'Vous êtes déjà inscrit à la newsletter.'
    end
  end

  def unsubscribe
    @subscriber = Subscriber.find_by(token: params[:token])

    if @subscriber
      @subscriber.destroy
      redirect_to root_path, notice: 'Vous avez été désinscrit de la newsletter.'
    else
      redirect_to root_path, notice: 'Vous êtes déjà désinscrit de la newsletter.'
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
