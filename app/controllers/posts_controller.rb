class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "記録に成功しました！"
    else
      render "new"
    end
  end

  def index
    # ユーザーごとに投稿一覧を表示させる
    @user = User.find_by(id: params[:user]) || current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(6)
    # 退会ユーザーの投稿ページは表示しない
    redirect_to posts_path if @user.is_deleted
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
    @user = User.find_by(id: @post.user_id)
    if @post.user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新に成功しました！"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "削除に成功しました！"
  end

  private

  def post_params
    params.require(:post).permit(:steps, :image, :title, :body)
  end
end
