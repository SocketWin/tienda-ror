require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", /Iniciar sesión/
    assert_select "h1", "Iniciar sesión"
    assert_select "form" do
      assert_select "input[name=?]", "session[login]"
      assert_select "input[name=?]", "session[password]"

    end
  end

  test "should create session" do
    post :create, session: { login: 'super', password: "contraseña"}
    # assert_redirected_to user_url(User.find_by_login('super').id)
    assert_response :success
  end

  test "should fail create session" do
    post :create, session: { login: 'JonhyL', password: "Fallo"}
    assert_equal flash[:error], "Fallo de autenticación: Los datos son incorrectos"
  end

  test "should delete destroy" do
    post :create, session: { login: 'JonhyL', password: "contraseña"}
    delete :destroy
    assert_redirected_to root_path
    assert_nil session[:remember_token]
    refute signed_in?
  end

  # test "should create user" do
  #   assert signed_in?
  #   assert_equal 'Bienvenido a Red Social', flash[:success]
  # end

end
