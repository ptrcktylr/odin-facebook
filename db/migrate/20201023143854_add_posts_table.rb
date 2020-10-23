class AddPostsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
