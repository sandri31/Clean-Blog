class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
