class PostsController < ApplicationController
  before_action :need_to_login, only: [:new, :create]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(user_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

    def user_params
      params.require(:post).permit(:content)
    end
end
