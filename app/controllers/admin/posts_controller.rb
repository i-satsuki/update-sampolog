class Admin::PostsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@posts = Post.page(params[:page]).per(10)
	end
end
