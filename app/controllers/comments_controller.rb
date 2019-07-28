# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  before_action :require_non_admin_user, only: %i[create]
  before_action :find_article, only: %i[create]

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @article }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  # Fetch an article by slug
  def find_article
    @article = Article.find_by(slug: params[:article_slug])
  end
end
