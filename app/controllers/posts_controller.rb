class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    # Now this action is handling both html and json queries for a specific post
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @post.to_json(only: [:title, :description, :id],
                                               include: [author: { only: [:name]}]) }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  # def post_data
  #   post = Post.find(params[:id])
  #   # with include: we tell to_json what associations to include
  #   # render json: post.to_json(include: :author)

  #   # we can also use only: to specify what data we want to return
  #   # NOTE: author is being passed inside an array because we are passing additional options
  #   render json: post.to_json(only: [:title, :description, :id],
  #                             include: [ author: { only: [:name]}])
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
