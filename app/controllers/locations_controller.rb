class LocationsController < ApplicationController
	before_action :find_location, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@locations = Location.all.order "created_at DESC"
		
	end

	def show
		#@location = Location.find(params[:id])
	# 	@photos = Photo.where(location_id: @location).order("created_at desc").to_a
		@comments = Comment.where(location_id: @location) 
		@tags = Location.find(params[:id]).tag_list

	#	@random_location = location.where.not(id: @location).order("RANDOM()").first
	end

	def new
		@location = current_user.locations.build
		# @photo = Photo.new(:title => "My photo \##{1 + (Photo.maximum(:id) || 0)}")
	end
	
	def create
		@location = current_user.locations.build(location_params)
		#@location.tag_list.add()
		#@paraams = params[:photo]
		#@photo = Photo.new(params[:photo])
		#@photo.location_id = @location.id
		#@photo.user_id = current_user.id
		#@photo.save


		if @location.save
			redirect_to @location
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @location.update(location_params)
			redirect_to @location
		else
			render 'edit'
		end
	end

	def destroy
		@location.destroy
		redirect_to root_path
	end

	def upvote
		@location.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@location.downvote_by current_user
		redirect_to :back
	end

	private

	def find_location
		@location = Location.find(params[:id])
	end

	def location_params
		params.require(:location).permit( :title, :description, :image, :lon, :lat, :tag_list)
	end	
end
