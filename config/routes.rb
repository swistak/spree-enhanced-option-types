Rails::Application.routes.draw do |map|
  post "/admin/products/:product_id/variants/regenerate", :to => "admin/variants#regenerate"
end
