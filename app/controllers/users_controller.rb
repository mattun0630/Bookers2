class UsersController < ApplicationController
		before_action :authenticate_user!
		before_action :correct_user, only: [:edit, :update ]
	def correct_user
		@user = User.find(params[:id])
		unless @user==current_user
               redirect_to user_path(current_user.id)
		end
	end


	def show
		@user =User.find(params[:id])
		@book =Book.new


	end
	def edit
		@user =current_user

	end

	def update
		@user = User.find(params[:id])
		if	@user.update(user_params)
			flash[:notice] = "successfully "
			redirect_to user_path(@user.id)
		else
			flash[:notice] = "error "
			render :edit
		end
	end


	def index
		@book =Book.new
		@users = User.all
	end
	private
	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
end
