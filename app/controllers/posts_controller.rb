class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      current_user.add_role :creator, @post
      flash[:errors] = "Post Created Successfully"
      redirect_to posts_path
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    current_user.add_role :editor, @post
    if @post.update(post_params)
      flash[:errors] = "Post Updated Successfully"
      redirect_to post_path(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to edit_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.delete
      flash[:errors] = "Post Deleted Successfully"
      redirect_to root_path(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to destroy_post_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
