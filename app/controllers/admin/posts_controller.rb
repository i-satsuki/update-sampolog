class Admin::PostsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@posts = Post.page(params[:page]).per(10)
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments.order(created_at: :desc)
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
    	redirect_to admin_posts_path, notice: "削除に成功しました！"
	end
end
