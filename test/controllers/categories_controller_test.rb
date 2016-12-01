require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:category_5)
    @categories=Category.all
  end

  test "no should get index" do
    get :index
    assert_response :redirect
    # assert_not_nil assigns(:products)
  end

  test "no should get index permissions" do
    sign_in User.second
    get :index
    assert_response :redirect
    # assert_not_nil assigns(:products)
  end

  test "should get index" do
    sign_in User.first
    get :index
    assert_response :success
    # assert_not_nil assigns(:categories)
    assert_select "table" do
      assert_select "thead" do
        assert_select "tr" do
          assert_select "th", "Título"
          assert_select "th", "Descripción"
        end
      end
      assert_select "tbody" do
        @categories.paginate(page:1, per_page: 25).each do |category|
          assert_select "tr" do
            assert_select "td", category.titulo
            assert_select "td", category.descripcion
          end
        end
      end
    end
    assert_select "div.pagination", 2
  end

  test "should get new" do
    sign_in User.first
    get :new
    assert_response :success
  end

  test "should create category" do
    sign_in User.first
    assert_difference('Category.count') do
      post :create, category: { descripcion: @category.descripcion, titulo: "ahorita si jaja" }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    sign_in User.first
    get :show, id: @category
    assert_response :success
    assert_select "a", "Descripción", @category.products.paginate(page:1, per_page: 4).count
    @category.products.paginate(page:1, per_page: 4).each do |product|
      assert_select "h2", product.titulo
      assert_select "div[class='col-xs-6 col-lg-4']"
      assert_select "img[alt=?]", product.titulo
      assert_select "a[href=?]", product_path(product)
      assert_select "span", product.precio.to_s
      assert_select "input[name='product_id']"
      assert_select "input[name='cantidad']"
      assert_select "form[action=?]", agregar_al_carrito_url do |f|
        assert_select f, "button"
      end
    end
    assert_select "div.pagination", 2
  end

  test "should get edit" do
    sign_in User.first
    get :edit, id: @category
    assert_response :success
  end

  test "should update category" do
    sign_in User.first
    patch :update, id: @category, category: { descripcion: @category.descripcion, titulo: @category.titulo }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    sign_in User.first
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end
    assert_redirected_to categories_path
  end
end
