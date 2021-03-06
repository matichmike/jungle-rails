class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASSWORD"]
  def show
    @productCount = Product.all.count
    @categoryCount = Category.all.count
  end
end
