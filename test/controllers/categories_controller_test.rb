require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:category_5)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, category: { descripcion: @category.descripcion, titulo: "ahorita si jaja" }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, id: @category
    assert_response :success
    assert_select "a", "Descripción", @category.products.paginate(page:1, per_page: 4).count
    @category.products.paginate(page:1, per_page: 4).each do |product|
      assert_select "h2", product.titulo
      assert_select "div[class='col-xs-6 col-lg-4']"
      assert_select "img[alt=?]", product.titulo
      assert_select "a[href=?]", product_path(product)
      assert_select "span", product.precio.to_s
    end
    assert_select "div.pagination", 2
  end

  test "should get edit" do
    get :edit, id: @category
    assert_response :success
  end

  test "should update category" do
    patch :update, id: @category, category: { descripcion: @category.descripcion, titulo: @category.titulo }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end
    assert_redirected_to categories_path
  end
end
