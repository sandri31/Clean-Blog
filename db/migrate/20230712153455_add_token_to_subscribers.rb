class AddTokenToSubscribers < ActiveRecord::Migration[7.0]
  def change
    add_column :subscribers, :token, :string
    add_index :subscribers, :token, unique: true
  end
end
