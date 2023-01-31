# frozen_string_literal: true

class Article < ApplicationRecord
  has_rich_text :body
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :body, presence: true, length: { minimum: 5, maximum: 5000 }
  validates :user_id, presence: true

  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]
end
