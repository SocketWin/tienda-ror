json.extract! product, :id, :titulo, :descripcion, :imagen, :precio, :created_at, :updated_at
json.url product_url(product, format: :json)