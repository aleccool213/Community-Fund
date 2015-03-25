class PostsController < ApplicationController
  before_filter :authenticate_user!

  def create
    if params[:content].present?
      post = Post.new
      post.user = current_user
      post.send("#{params[:object_type]}_id=", params[:object_id])
      post.content = params[:content]
      post.save

      @type = params[:object_type]
      @id = params[:object_id]

      render json: {status: :success, content: params[:content], url: post.user.avatar_url(70), username: post.title_text,  userpath: "/users/#{post.user.username}", timestamp: post.updated_at.strftime("%m/%d/%Y at %I:%M%p")}
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
end
