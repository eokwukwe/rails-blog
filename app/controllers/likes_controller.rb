# frozen_string_literal: true

# LikesController
class LikesController < ApplicationController
  before_action :require_non_admin_user, only: %i[create destroy]
  before_action :find_article, only: [:create]
  before_action :find_like, only: [:destroy]

  def create
    @article.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @article = Article.find(@liked.article_id)
    @liked.destroy if already_liked?(current_user, @article)
    respond_to do |format|
      format.js
    end
  end

  private

  # Fetch an article by slug
  def find_article
    @article = Article.find_by(slug: params[:article_slug])
  end

  # Check is a user has already liked an article
  def already_liked?(current_user, article)
    Like.where(user_id: current_user.id,
               article_id: article.id).exists?
  end

  def find_like
    @liked = Like.find(params[:id])
  end
end
