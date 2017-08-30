class PostController < ApplicationController

    before_action :set_post, only: [:show, :destroy, :edit, :update]

    def create
        puts "######################{post_params}"
        @post = current_user.posts.create(post_params)
        
        redirect_to "/"
    end
    
    def show
        # @post = Post.find(params[:id])
        @comments = @post.comments.all
        
        respond_to do |format|
            format.js { render 'home/show.js.erb' }
        end
    end
    
    def edit
        respond_to do |format|
            format.js { render 'home/edit.js.erb' }
        end
    end
    
    def update
        respond_to do |format|
            if @post.update(post_params)            
                format.js { render 'home/update.js.erb' }
            else
                redirect_to :back
            end
        end        
    end
    
      def destroy
        @post.destroy
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Post was successfully destroyed.' }
          format.json { head :no_content }
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
    
    def set_post
        @post = Post.find(params[:id])
    end
    
    def post_params
        params.require(:post).permit(:title, :content)
    end
    def comment_params
        params.require(:comment).permit(:content)
    end
end
