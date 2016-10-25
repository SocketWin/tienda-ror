require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # El titulo debe ser obligatorio

  test "El titulo obligatorio" do
    category = Category.new
    refute category.valid?, "No deberia ser categoria valida por que no tiene titulo"
  end

end
