module Api
  module V1
    class CategoriesController < ApplicationController
    	before_action :authenticate_user!
      def index
        @categories = Category.joins(:products).select('categories.*, count(products.id) as products_count').group('categories.id').order(:title)
        render json: @categories
      end
    end
  end
end