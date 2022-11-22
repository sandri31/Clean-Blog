class Contact < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: ENV['EMAIL_REGEX']
  attribute :phone
  attribute :message,   validate: true

  def headers
    {
      to: ENV['EMAIL_TO'],
      subject: "#{name} te contact de ton site: Clean Blog'",
      from: %("#{name}" <#{email}>)
    }
  end
end
