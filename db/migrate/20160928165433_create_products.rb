class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :titulo
      t.text :descripcion
      t.string :imagen
      t.decimal :precio, precision: 38, scale: 8

      t.timestamps null: false
    end
    add_index :products, :titulo, unique: true
  end
end
