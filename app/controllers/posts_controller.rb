class PostsController < ApplicationController
    has_many: :comments, 
    :has_one :tag
    def new
        @post = Post.new
    end

    #GET /posts/1
    def show
        @post = Post.find(params[:id])
        render json: @posts, include: :comments
    end

    #GET /posts
    def index
        @posts = Post.all

        render json: @posts, include: :comments
    end
    #POST /posts
    def create
        @post = Post.new(params[:post].permit(:title, :username, :img_url))
        
        if @post.save
            render json: @post, include: :comments , status: :created
        else
            render json: @post.errors, status: :unprocessable_entity
        end
    end

    #PATCH/PUT /posts/1
    def update
        if @post.update(post_params)
          render json: @post, include: :comments
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end
    
      def add_post
        @post = Post.find(params[:id])
        @comment = Comment.find(params[:comment_id])
        @post.comments << @comment
        # @flavor.foods << @food
    
        render json: @post, include: :comment
      end
    
      # DELETE /foods/1
      def destroy
        @post.destroy
      end

end
