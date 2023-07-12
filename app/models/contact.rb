# frozen_string_literal: true

class Contact < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: ENV['EMAIL_REGEX']
  attribute :phone
  attribute :message, validate: true

  def headers
    {
      to: ENV['MAILER_FROM'],
      subject: "#{name} te contact de ton site: Clean Blog'",
      from: 'contact@florentsandri.fr',
      reply_to: %("#{name}" <#{email}>)
    }
  end
end
