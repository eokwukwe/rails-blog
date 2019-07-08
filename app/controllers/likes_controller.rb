# frozen_string_literal: true

# LikesController
class LikesController < ApplicationController
  before_action :find_article
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:danger] = "You've already liked this article"
    else
      @article.likes.create(user_id: current_user.id)
    end
    redirect_to article_path(@article)
  end

  def destroy
    if !already_liked?
      flash[:notice] = 'Cannot unlike'
    else
      @like.destroy
    end
    redirect_to article_path(@article)
  end

  private

  # Fetch an article by slug
  def find_article
    @article = Article.find_by(slug: params[:article_slug])
  end

  # Check is a user has already liked an article
  def already_liked?
    Like.where(user_id: current_user.id, article_id: @article.id).exists?
  end

  def find_like
    @like = @article.likes.find_by(article_id: @article.id)
  end
end
