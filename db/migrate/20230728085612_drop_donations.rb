class DropDonations < ActiveRecord::Migration[7.0]
  def change
    drop_table :donations
  end
end
