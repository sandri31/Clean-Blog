# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def newsletter_email(subscriber)
    @subscriber = subscriber
    @articles = Article.where(publicly_published: true).order(created_at: :desc).limit(4)
    mail(to: @subscriber.email, subject: 'Voici le dernier article de mon blog')
  end
end
