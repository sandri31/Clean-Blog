# frozen_string_literal: true

# This class represents an article in the blog. It contains the title, body, image, and author information.
class Article < ApplicationRecord
  has_rich_text :body
  has_one_attached :image
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :body, presence: true, length: { minimum: 5, maximum: 9000 }
  validates :user_id, presence: true

  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]

  scope :filter_by_title, ->(title) { where('title ILIKE ?', "%#{title}%") }

  after_save :send_newsletter, if: :publicly_published?

  def publicly_published?
    publicly_published
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  private

  def send_newsletter
    Subscriber.find_each do |subscriber|
      NewsletterMailer.new_article(self, subscriber).deliver_now
    end
  end
end
