module Api
  module V1
    class OrderController < ApplicationController
    	
      before_action :authenticate_user!
      before_action :load_user
      
      
		  def create
		  	cart = ShoppingCart.new(token: @user)		  	
		    order = cart.order
	  		order.update_attribute(:status, 'open')

	  		new_cart = ShoppingCart.new(token: @user)
		    new_order = new_cart.order
      	new_order_items = OrderItem.joins(:product).select("products.title, order_items.*").where(order_id: new_order.id)
		    render json: new_order_items
		  end

		
		  private


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