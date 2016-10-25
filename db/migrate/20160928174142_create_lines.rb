class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.references :product, index: true, foreign_key: true
      t.references :car, index: true, foreign_key: true
      t.integer :cantidad

      t.timestamps null: false
    end
  end
end
