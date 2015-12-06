class UsersController < ApplicationController
	def show
	  @user = User.find(params[:id])
	  @locations = Location.all.order("created_at DESC").where(user_id: params[:id]).order("created_at DESC").paginate(:page => params[:page],:per_page => 16)
	  @liked_locations = @user.find_liked_items[0...9]
	  
	  @locations_added= @locations.size
	  @locations_liked= @user.find_liked_items.size
	  @member_since = @user.created_at
	  @last_sign = @user.last_sign_in_at
	end
end
