class ChangeCategoryInArticles < ActiveRecord::Migration[7.0]
  def change
    change_column_null :articles, :category_id, false
  end
end
