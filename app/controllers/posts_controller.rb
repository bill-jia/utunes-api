class PostsController < ApplicationController 
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :process_params, only: [:create, :update]
  after_action :verify_authorized, :except => :index  

  # GET /posts
  # GET /posts.json
  def index
    if params[:user_id]
      @posts = User.find(params[:user_id]).posts
    else
      @posts = Post.all
    end
    render json: @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    authorize @post
    render json: @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    authorize @post
    if @post.save
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    head :no_content
  end

  private
    def process_params
      unless params["file"].blank?
        params["post"] = JSON.parse(params["post"]).with_indifferent_access
        params["post"]["cover_image"] = params["file"]
        params.delete("file")        
      end
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :user_id, :cover_image, :author, :id)
    end
end
