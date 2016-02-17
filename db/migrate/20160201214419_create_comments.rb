class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      #index tells the db to index the post_id column for easy searching.
      t.references :post, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
