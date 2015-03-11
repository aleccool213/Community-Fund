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

      render json: {status: :success, content: params[:content], url: post.user.avatar_url(50), timestamp: post.updated_at.strftime("%m/%d/%Y at %I:%M%p")}
    else
      render json: {status: :failure}
    end
  end
end
