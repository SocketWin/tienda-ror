require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @product = products(:product_1)
    @line = lines(:one)
  end

  test "not_should_in_my_car" do
    get :my_car
    assert_redirected_to signin_url

  end

  test "should get index" do
    get :index
    assert_response :found
    # assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "h1", "Registrarme"
    assert_select "form[action=?]", users_path do |form|
      assert_select form, "div[class='form-group']" do |div|
        assert_select div, "input" do
          assert_select "[class=?]", "form-control"
          # assert_select "[name=?]", /.+/
        end
        assert_select div, "label"
      end
      assert_select "input[value=?]", "Envíar"
    end
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { login: "nicky", name: "Naulo", direccion: "por ahi", cuenta_bancaria: "2214342234",
                            edad: 15, password: "algo1992", password_confirmation: "algo1992" }
    end
    assert_redirected_to root_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    sign_in @user
    patch :update, id: @user, user: { login: "neutron", name: "Jimmy", direccion: "por ahi", cuenta_bancaria: "0000000",
                                      edad: 15, password: "algo1992", password_confirmation: "algo1992" }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test "should get my_car" do
    sign_in User.first
    get :my_car
    assert_response :success
    @lines = User.find_by_id(1).car.lines.paginate(page:1, per_page: 10)
    assert_select "h1", "Mi Carrito"
    assert_select "form[action=?]", '/my_car' do
      assert_select "button", "Confirmar la Compra"
    end
    assert_select "table" do |table|
      assert_select table, "thead tr th", "Imagen Producto"
      assert_select table, "thead tr th", "Descripción Producto"
      assert_select table, "thead tr th", "Cantidad"
      assert_select table, "thead tr th", "Precio"
      assert_select table, "thead tr th", "Acciones"
      assert_select table, "tbody" do
        @lines.each do |line|
          assert_select "tr td form[action=?]", actualizar_carrito_url do
            assert_select "input[value=?]", line.id.to_s
            assert_select "input[value=?]", line.cantidad.to_s
            assert_select "button", "Actualizar"
          end
          assert_select "tr td img[alt=?]", line.product.descripcion
          assert_select "tr td", line.product.descripcion
          assert_select "tr td", line.product.precio.to_s
        end
      end
      assert_select "tr td", 50
    end
  end

  test "should not get edit without user" do
    get :edit, id: @user
    assert_redirected_to signin_path
  end
  test "should not update user without a user" do
    patch :update, id: @user, user: { name: @user.name, password: @user.password, password_confirmation:
        @user.password_confirmation, login: @user.login }
    assert_redirected_to signin_path
  end
  test "should not get edit with a different user" do
    sign_in User.last
    get :edit, id: @user
    assert_redirected_to root_path
  end
  test "should not update user with a different user" do
    sign_in User.last
    patch :update, id: @user, user: { name: @user.name, password: @user.password, password_confirmation:
        @user.password_confirmation, login: @user.login }
    assert_redirected_to root_path
  end

  test "should not get index" do
    get :index
    assert_redirected_to signin_path
  end

=begin
  test "funcion_agregar_al_carrito" do
    sign_in User.second
    assert_difference 'Line.count' do
      post :actualizar_carrito, product_id:45, cantidad:5
    end
    assert_response :success
  end

=end

  test "funcion_actualizar_carrito_falla" do
    sign_in User.second
    request.env["HTTP_REFERER"]=my_car_url
    post :actualizar_carrito, line_id:@line.id, cantidad:1
    assert_response :error
  end

  test "funcion_actualizar_carrito_funciona" do
    sign_in User.first
    request.env["HTTP_REFERER"]=my_car_url
    post :actualizar_carrito, line_id:@line.id, cantidad:1
    assert_response :redirect
    assert Line.find_by(id: @line.id).cantidad == 1
  end

  test "funcion_actualizar_carrito_cero" do
    sign_in User.first
    request.env["HTTP_REFERER"]=my_car_url
    id = @line.id
    post :actualizar_carrito, line_id:@line.id, cantidad:0
    assert_response :redirect
    assert Line.find_by(id: id).nil?
    @line = Line.find_by(id: 2)
    id = @line.id
    post :actualizar_carrito, line_id:@line.id, cantidad:-1
    assert_response :redirect
    assert Line.find_by(id: id).nil?
  end



end
