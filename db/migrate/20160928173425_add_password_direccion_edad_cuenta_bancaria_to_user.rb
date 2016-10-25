class AddPasswordDireccionEdadCuentaBancariaToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :direccion, :string
    add_column :users, :edad, :integer
    add_column :users, :cuenta_bancaria, :string
  end
end
