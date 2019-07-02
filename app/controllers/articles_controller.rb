# frozen_string_literal: true

# ArticlesController
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin_and_same_user, only: %i[destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 8)
                       .order('created_at DESC')
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article created successfully'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article updated successfully'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @article.destroy
    flash[:danger] = 'Article deleted  successfully'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description,
                                    category_ids: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = 'Articles can only be edited by their author'
      redirect_to root_path
    end
  end

  def require_admin_and_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = 'Only admin or account owners can perform that action'
      redirect_to root_path
    end
  end
end
