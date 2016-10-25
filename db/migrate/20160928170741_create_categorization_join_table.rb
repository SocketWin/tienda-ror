class CreateCategorizationJoinTable < ActiveRecord::Migration
  def change
    create_join_table :products, :categories, table_name: :categorization, column_options: { null: true } do |t|
      t.index [:product_id]
      t.index [:category_id]
      t.index [:product_id, :category_id], unique: true
    end
  end
end