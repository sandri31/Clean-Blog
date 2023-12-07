# frozen_string_literal: true

# This class represents an article in the blog. It contains the title, body, image, and author information.
class Article < ApplicationRecord
  has_rich_text :body
  has_one_attached :image
  belongs_to :user
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :body, presence: true, length: { minimum: 5, maximum: 15000 }
  validates :user_id, presence: true

  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]

  scope :filter_by_title, ->(title) { where('title ILIKE ?', "%#{title}%") }

  after_save :send_newsletter, if: :publicly_published_and_not_previously?

  def publicly_published_and_not_previously?
    publicly_published? && !newsletter_sent?
  end

  private

  def send_newsletter
    Subscriber.find_each do |subscriber|
      NewsletterMailer.new_article(self, subscriber).deliver_now
    end

    update_column(:newsletter_sent, true)
  end
end
