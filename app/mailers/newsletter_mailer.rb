# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def new_article(article)
    @article = article
    mail(to: Subscriber.pluck(:email), subject: 'Nouvel article disponible !')
  end
end
