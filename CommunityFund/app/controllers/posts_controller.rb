class PostsController < ApplicationController
  before_filter :authenticate_user!

  def create
    if params[:content].present?
      @post = Post.new
      @post.user = current_user
      @post.send("#{params[:object_type]}_id=", params[:object_id])
      @post.content = params[:content]
      @post.save
      
      render json: {status: :success, html: render_to_string("posts/single_post", layout: false)}
    else
      render json: {status: :failure}
    end
  end

  def index
    type = params[:type]
    id = params[:id]
    page = params[:page]
    @posts = type.capitalize.constantize.find_by_id(id).posts.paginate(page: page, per_page: 15).order("updated_at DESC")
    if request.xhr?
      render json: {success: true, html: render_to_string("index", layout: false)}
    end
  end

  def destroy
    type = params[:object_type]
    id = params[:id]
    object_id = params[:object_id]
    @post = type.capitalize.constantize.find_by_id(object_id).posts.find_by_id(id)

    if @post.present?
      @post.destroy
      render json: {success: true}
    else
      render json: {status: :failure}
    end
  end
end
