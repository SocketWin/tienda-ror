require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:product_1)
    @products=Product.all
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
    # assert_not_nil assigns(:products)
    assert_select "table" do
      assert_select "thead" do
        assert_select "tr" do
          assert_select "th", "Título"
          assert_select "th", "Descripción"
          assert_select "th", "Imagen"
          assert_select "th", "Precio"
        end
      end
      assert_select "tbody" do
        @products.paginate(page:1, per_page: 25).each do |product|
          assert_select "tr" do
            assert_select "td", product.titulo
            assert_select "td", product.descripcion
            assert_select "td", product.imagen
            assert_select "td", product.precio.to_s
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

  test "should create product" do
    sign_in User.first
    assert_difference('Product.count') do
      post :create, {product: { descripcion: "product.descripcion", imagen: "product.jpg", precio: 15.99,
                                titulo: "Ahora sin errror jaja", category_ids: [1]}}
    end
    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    sign_in User.first
    get :show, id: @product
    assert_response :success
    assert_select "img[alt='producto']"
    assert_select "p", @product.descripcion
    assert_select "h2", @product.titulo
    assert_select "p strong", "$"+@product.precio.to_s
    assert_select "form[action=?]", agregar_al_carrito_url
    assert_select "input[name='cantidad']"
    assert_select "input[name='product_id']"
  end

  test "should get edit" do
    sign_in User.first
    sign_in User.first
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    sign_in User.first
    patch :update, id: @product, product: { descripcion: "product.descripcion", imagen: "product.png",
                                            precio: 10, titulo: "title sin error", category_ids: [1] }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    sign_in User.first
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end
    assert_redirected_to products_path
  end
end
