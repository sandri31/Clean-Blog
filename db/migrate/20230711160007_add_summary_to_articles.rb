class AddSummaryToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :summary, :text
  end
end
