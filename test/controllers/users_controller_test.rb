require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @product = products(:product_1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
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
      assert_select "input[type='submit' class='btn btn-primary']", "Envíar"
    end
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { login: "nicky", name: "Naulo", direccion: "por ahi", cuenta_bancaria: "2214342234",
                            edad: 15, password: "algo1992", password_confirmation: "algo1992" }
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
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
    post :actualizar_carrito, product_id: @product.id, cantidad: 1
    assert_response :success
  end

  test "should get my_car" do
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

  end

end
