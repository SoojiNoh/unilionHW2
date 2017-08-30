class HomeController < ApplicationController
  def index
    @quote = Quote.order("RANDOM()").first.content
    @posts = Post.all
    @post = Post.new
  end
  
  def random
    @quote = Quote.order("RANDOM()").first.content
  end

end
