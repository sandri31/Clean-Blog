# frozen_string_literal: true

# This class represents an article in the blog. It contains the title, body, image, and author information.
class Article < ApplicationRecord
  has_rich_text :body
  has_one_attached :image
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :body, presence: true, length: { minimum: 5, maximum: 10000 }
  validates :user_id, presence: true

  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]
end
