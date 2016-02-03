class PostsController < ApplicationController
  def index
    @posts = spam(Post.all)
  end

  def show
  end

  def new
  end

  def edit
  end

  def spam(posts)
    posts.each_with_index.map do |post, i|
      if i == 0 || i % 5 == 0
        post[:title] = "SPAM"
      end
    end
    posts
  end

end
