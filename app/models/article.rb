class Article < ApplicationRecord
  has_rich_text :description
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3 , maximum: 100 }
  validates :description, presence: true, length: { minimum: 5 , maximum: 5000 }
  validates :user_id, presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
end
