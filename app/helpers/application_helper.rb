# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def gravatar_for(email, size: 120)
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: email, class: 'gravatar rounded-circle')
  end
end
