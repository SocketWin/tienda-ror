require 'test_helper'

class InicioControllerTest < ActionController::TestCase
  setup do
    @categories = Category.all
  end
  test "should get index" do
    get :index
    assert_response :success
    assert_select "h1","Bienvenido a La Tienda Virtual"
    assert_select "title", "La Tienda Virtual | Inicio"
    assert_select "a", "Registrarte"
    assert_select "a[href=?]", "/sign_up"
    assert_select "a", "Iniciar Sesión"
    assert_select "a[href=?]", "/sign_in"
    @categories.paginate(page:1, per_page: 25).each do |category|
      assert_select "h2", category.titulo
      assert_select "div[class='col-xs-6 col-lg-4 image']"
      assert_select "a[href=?]", category_path(category)
    end
    assert_select "div.pagination", 2
    assert_select "a[href='/my_car']", "Mi carrito"
    assert_select "img[alt='usuario']"
    assert_select "input[placeholder='buscar producto']"
  end

  test "should get sign_up" do
    get :sign_up
    assert_response :success
  end

  test "should get sign_in" do
    get :sign_in
    assert_response :success
  end

  test "should post buscar_producto" do
    post :buscar_producto, titulo: "mac"
    assert_response :success
  end

end
