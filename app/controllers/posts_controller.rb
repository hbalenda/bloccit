class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    #create a new instance of post
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    #if post is successfully saved, display success message
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      #if save is unsuccessful, display error message and render the new view again
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
  end
end
