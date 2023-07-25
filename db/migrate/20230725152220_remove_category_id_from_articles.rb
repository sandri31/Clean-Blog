class RemoveCategoryIdFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :category_id
  end
end
