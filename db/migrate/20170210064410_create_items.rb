class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.text :info
      t.string :avatar, null: false
      t.integer :media, limit: 2, null: false, default: 1
      t.integer :category_id, null: false
    end
  end
end
