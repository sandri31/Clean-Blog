# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def newsletter_email
    @subscriber = params[:subscriber]
    @article = params[:article]
    mail(to: @subscriber.email, subject: 'Un nouvel article est disponible sur le blog')
  end
end
