class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@users = User.page(params[:page]).per(10)
	end


	private

	def user_params
		params.require(:user).permit(:is_deleted)
	end

end
