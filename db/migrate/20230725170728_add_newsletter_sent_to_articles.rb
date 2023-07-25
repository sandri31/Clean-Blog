class AddNewsletterSentToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :newsletter_sent, :boolean, default: false
  end
end
