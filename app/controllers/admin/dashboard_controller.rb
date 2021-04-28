class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => "Jungle", :password => "book"

  def show
  @product_count = Product.count
  @categories = Product.group(:category_id).count.length()
  end

end
