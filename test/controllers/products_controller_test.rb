require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:product_1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, {product: { descripcion: "product.descripcion", imagen: "product.jpg", precio: 15.99,
                                titulo: "Ahora sin errror jaja", category_ids: [1]}}
    end
    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
    assert_select "img[alt='producto']"
    assert_select "p", @producto.descripcion
    assert_select "h2", @producto.titulo
    assert_select "p", @producto.precio
    assert_select "form[action='/actualizar_carrito']"
    assert_select "input[name='cantidad']"
    assert_select "input[name='product_id']"
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { descripcion: "product.descripcion", imagen: "product.png",
                                            precio: 10, titulo: "title sin error", category_ids: [1] }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end
    assert_redirected_to products_path
  end
end
