module Api
  module V1
    class ProductsController < ApplicationController
    	before_action :authenticate_user!
		  def index
		      @category = Category.find(params[:category_id])
		      @products = @category.products.order(:title)
		    render json: @products
		  end
		end
  end
end