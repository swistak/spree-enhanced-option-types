Rails::Application.routes.draw do
  post "/admin/products/:product_id/variants/regenerate", :to => "admin/variants#regenerate"
end
