class UpdateNewsletterSentForExistingArticles < ActiveRecord::Migration[7.0]
  def up
    Article.where(publicly_published: true).update_all(newsletter_sent: true)
  end

  def down
    # This is not reversible, so we leave this blank
  end
end
