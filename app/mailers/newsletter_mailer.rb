# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def new_article(article, subscriber)
    @article = article
    @subscriber = subscriber
    mail(to: @subscriber.email, subject: 'Nouvel article disponible !')
  end

  def welcome_email(subscriber, article)
    @subscriber = subscriber
    @article = article
    @article = Article.order(created_at: :desc).first
    mail(to: @subscriber.email, subject: 'Bienvenue sur notre newsletter !')
  end
end
