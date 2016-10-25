require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @car1 = cars(:one)
    @car2 = cars(:two)
  end

  # El carro deberá tener un método que devuelva la suma total de todos los productos que hay en él
  test "método que devuelva la suma" do
    # refute assert_throws(NoMethodError, "Si lanza el error") {@car1.suma_total}, "Deberia tener un metodo suma_total"
    assert_nothing_raised(NoMethodError){@car1.suma_total}
  end

end
