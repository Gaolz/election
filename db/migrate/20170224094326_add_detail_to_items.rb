class AddDetailToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :slug, :string
  end
end
