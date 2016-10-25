class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :titulo
      t.text :descripcion

      t.timestamps null: false
    end
    add_index :categories, :titulo, unique: true
  end
end
