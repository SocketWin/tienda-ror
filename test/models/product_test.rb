require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @product = products(:product_1)
    @category = categories(:category_1)
  end

  # Se deberá comprobar la presencia de todos los datos
  test "todos los campos requeridos" do
    product = Product.new
    refute product.valid?, "Debería ser invalido por que todos son requeridos"
    refute product.errors[:titulo].blank?, "debe tener titulo"
    refute product.errors[:descripcion].blank?, "debe tener descripcion"
    # refute product.errors[:imagen].blank?, "debe tener imagen"
    refute product.errors[:precio].blank?, "debe tener precio"
  end

  # así como también comprobar el título del producto es único,
  test "El titulo debe ser unico" do
    Product.create({ descripcion: "descripcion", imagen: "imagen.jpg", precio: 9.99, titulo: "repetido" })
    # assert_raises(ActiveRecord::RecordNotUnique) do
    p = Product.new({ descripcion: "descripcion", imagen: "imagen.jpg", precio: 9.99, titulo: "repetido" })
    refute p.valid?, "No deberia ser valido por que es repetido el titulo"
    # end
  end

  # que el precio es un número (el precio puede ser 0, es decir gratis, pero debe ser un número)
  test "el precio debe ser un numero" do
    product = Product.new({ descripcion: "descripcion", imagen: "imagen.png", precio: 9.9, titulo: "nada repetido" })
    product.categories << @category
    assert product.save, "deberia permitir guardar"
    product.precio="hola"
    refute product.valid?, "no deberia ser valido por que es numero"
  end

  # que la imagen sigue un formato jpg o png (o cualquier otra extensión que consideres oportuna).
  test "la imagen sigue un formato jpg/png" do
    product = Product.new({ descripcion: "descripcion", imagen: "imagen.jpg", precio: 9.9, titulo: "nada repetido" })
    product.categories << @category
    assert product.save, "deberia permitir guardar"
    product.imagen="imagen.txt"
    refute product.valid?, "no deberia ser valido por que es txt"
  end

  # Por lo cual un producto deberá ser como mínimo de una categoría
  test "un producto deberá ser como mínimo de una categoría" do
    product = Product.new({ descripcion: "descripcion", imagen: "imagen.jpg", precio: 9.9, titulo: "other repetido" })
    refute product.valid?, "no deberia ser valido por que el producto no tiene categoria"
  end

  # No podrá haber relaciones repetidas en dicha tabla.
  test "No podrá haber relaciones repetidas" do
    cate = Category.find_by_id(55)
    @product.categories << cate
    assert_raise(ActiveRecord::RecordNotUnique) do
      @product.categories << cate
    end
  end

  test "Comprobar valores por defecto" do
		product = Product.new
		assert_equal product.imagen, "product.png"
	end

end
