require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @car1 = cars(:one)
    @car2 = cars(:two)
  end

  # un usuario tiene un carro de la compra
  test "un usuario tiene un carro de la compra" do
    assert_raise(NoMethodError) do
      @user1.car << @car2
    end
  end

  # Los usuarios deberán tener funciones para añadir productos al carro a través de las líneas
  test "funcion agregar_producto" do
    assert_nothing_raised(NoMethodError) {@user1.agregar_producto(Product.first, 2)}
  end

  # Los usuarios deberán tener funciones para quitar productos del carro a través de las líneas
  test "funcion quitar_linea" do
    assert_nothing_raised(NoMethodError) {@user1.quitar_linea(Line.first)}
  end
  test "password debe tener como mínimo 6 char y estar confirmada" do
    user = User.first
    user.password = "asd"
    user.password_confirmation = "asd"
    assert user.invalid?, "No debería ser válido por el tamaño de la contraseña"
    user.password = "asdasd"
    user.password_confirmation = "asdasd"
    assert user.valid? , " Debería ser válido"
    user.password = "asdasd123"
    user.password_confirmation = "asdasd123"
    assert user.valid? , "También debería ser válido"
    user.password = "asdasdasd"
    user.password_confirmation = "asdasdqwe"
    refute user.valid?, "password y password_confirmation deben ser iguales"
  end

  test "Comprobar la existencia de metodos auxiliares" do
    user = User.new
    assert_respond_to user, "quitar_linea"
    assert_respond_to user, "agregar_producto"
  end

  # Da error este test
  # test "Comprobar_existencia_de_los_atributos" do
  #   assert_respond_to user, "remember_token"
  #   assert_respond_to user, "authenticate"
  # end

  test "Comprobar_que_cuando_guardamos_un_usuario_se_crea_un_remember_token" do
    user = User.last.dup
    user.remember_token = nil
    user.password = "password"
    user.password_confirmation = "password"
    user.login = "Login_No_Registrado"
    user.save
    refute_nil user.remember_token
  end

end
