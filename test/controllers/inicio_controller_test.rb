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
    assert_select "a[href=?]", signup_path
    assert_select "a", "Iniciar Sesión"
    assert_select "a[href=?]", signin_path
    @categories.paginate(page:1, per_page: 25).each do |category|
      assert_select "h2", category.titulo
      assert_select "div[class='col-xs-6 col-lg-4 image']"
      assert_select "a[href=?]", category_path(category)
    end
    assert_select "div.pagination", 2
    assert_select "input[placeholder='buscar producto']"
    assert_select "a[href='/my_car']", false
    assert_select "img[alt='usuario']", false
  end

  test "should_mostrar_carrito" do
    sign_in User.first
    get :index
    assert_response :success
    assert_select "a[href='/my_car']", "Mi carrito"
    assert_select "img[alt='usuario']"
  end

  test "should post buscar_producto" do
    post :buscar_producto, titulo: "mac"
    assert_response :success
  end

  test "Comprobar cabeceras sin loguear" do
    current_user = nil
    get :index
    assert_select "a", "Tienda Virtual"
    assert_select "a", "Registrarte"
    assert_select "a", "Iniciar Sesión"
  end
  test "Comprobar cabeceras cuando estamos logueados" do
    sign_in User.first
    get :index
    assert_select "a", "Tienda Virtual"
    assert_select "a", "Perfil"
    assert_select "a", "Configuración"
    assert_select "a", "Cerrar sesión"
  end

end
