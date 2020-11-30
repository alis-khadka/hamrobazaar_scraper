class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :url
      t.string :title
      t.string :description
      t.string :price
      t.string :mobile_number
      t.datetime :refetch_after
      t.timestamps
    end

    add_index :products, :url, unique: true
  end
end
