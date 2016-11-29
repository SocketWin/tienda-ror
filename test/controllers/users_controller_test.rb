require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @product = products(:product_1)
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

  test "Deberia actualizar carrito" do
    sign_in User.first
    post :actualizar_carrito, product_id: @product.id, cantidad: 1
    assert_response :success
  end

  test "should get my_car" do
    sign_in User.first
    get :my_car
    assert_response :success
    @lines = User.find_by_id(1).car.lines.paginate(page:1, per_page: 10)
    assert_select "h1", "Mi Carrito"
    assert_select "table[class='table table-striped']" do |table|
      assert_select table, "thead tr th", "Imagen Producto"
      assert_select table, "thead tr th", "Descripción Producto"
      assert_select table, "thead tr th", "Cantidad"
      assert_select table, "thead tr th", "Precio"
      assert_select table, "thead tr th", "Acciones"
      assert_select table, "tbody"# do |tbody|
      # end
      # @lines.paginate(page:1, per_page: 10).each do |line|
      #   assert_select "tr td img[alt=? height='72' width='72']", line.product.descripcion
      #   assert_select "tr td", line.product.descripcion
      #   assert_select "tr td", line.cantidad
      #   assert_select "tr td", line.product.precio
      #   assert_select "tr td form[action=? method='post']",
      #                 quitar_linea_path(line.id) do |form|
      #     assert_select form,
      #                   "input[type='submit' class='btn btn-danger btn-sm']" do |submit|
      #       assert_select submit, "span[class='glyphicon glyphicon-trash']"
      #     end
      #   end
      # end
      assert_select "tr td", 50
    end
    assert_select "form[action=?]", '/my_car' do
      assert_select "button", "Confirmar la Compra"
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

  test "funcion_agregar_al_carrito" do
    sign_in User.second
    assert_difference 'Line.count' do
      post :actualizar_carrito, product_id:45, cantidad:5
    end
    assert_response :success
  end

  test "funcion_actualizar_carrito" do
    sign_in User.second
    post :actualizar_carrito, product_id:@product.id, cantidad:1
    assert_response :unprocessable_entity
    sign_in User.first

    assert_response :success
  end

end
