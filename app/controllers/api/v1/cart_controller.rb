module Api
  module V1
    class CartController < ApplicationController
    	
    	before_action :authenticate_user!
      before_action :load_user
      
      def index
      	cart = ShoppingCart.new(token: @user)
      	order = cart.order
      	order_items = OrderItem.joins(:product).select("products.title, order_items.*").where(order_id: order.id)
		    render json: {order: order, items: order_items}
		  end

		  def create
		  	cart = ShoppingCart.new(token: @user)
		  	cart.add_item(
		      product_id: req_params[:id],
		      quantity: req_params[:quantity]
		    )
		    order = cart.order
      	order_items = OrderItem.joins(:product).select("products.title, order_items.*").where(order_id: order.id)
		    render json: {order: order, items: order_items}
		  end

			def destroy
		  	cart = ShoppingCart.new(token: @user)
		  	cart.remove_item(
		      id: params[:id]
		    )
		    order = cart.order
      	order_items = OrderItem.joins(:product).select("products.title, order_items.*").where(order_id: order.id)
		    render json: {order: order, items: order_items}
		  end

		  private

		  def req_params
		    params.require(:product).permit :id, :quantity
		  end

			def load_user
		    
		    @user = User.find_by(email: request.headers['X-User-Email'], authentication_token: request.headers['X-User-Token'])
		    if @user
		      return @user
		    else
		      render json: {
		        messages: "Cannot get User",
		        is_success: false,
		        data: {}
		      }, status: :failure
		    end
		  end

    end
  end
end