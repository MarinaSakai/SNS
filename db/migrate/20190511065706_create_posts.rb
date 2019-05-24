class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :content
      t.string :scope_of_disclosure

      t.timestamps
    end
  end
end
