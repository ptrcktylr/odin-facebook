class FixColumnTypes < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :provider, :text
    change_column :users, :uid, :text
  end
end
