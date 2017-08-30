class PostController < ApplicationController

    def create
        puts "######################{post_params}"
        @post = current_user.posts.create(post_params)
        
        redirect_to "/"
    end
    
    def show
        @post = Post.find(params[:id])
        @comments = @post.comments.all
        
        respond_to do |format|
            format.js { render 'home/show.js.erb' }
        end
    end
    
    def create_comment
        puts "###############creating_comment"
        @comment = current_user.comments.create(params.require(:comment).permit(Comment.attribute_names.map(&:to_sym)))
        @post_id = @comment.post_id
        puts "###############"+@comment.inspect
        respond_to do |format|  
            format.js { render 'home/create_comment.js.erb'}
        end 
    end
    
    private
    
    def post_params
        params.require(:post).permit(:title, :content)
    end
    def comment_params
        params.require(:comment).permit(:content)
    end
end
