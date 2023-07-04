class AddPubliclyPublishedToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :publicly_published, :boolean, default: true
  end
end
