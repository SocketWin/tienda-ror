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
    assert_response :redirect
  end

  test "should get my_car" do
    get :my_car
    assert_response :success
  end

end
