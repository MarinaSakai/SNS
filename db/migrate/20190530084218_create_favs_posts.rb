class CreateFavsPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :favs_posts do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
