class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    @article.user = current_user

    if @article.save
      flash[:notice] = "Article created successfully"

      redirect_to @article
    else
      render "new"
    end
  end

  def update
    @article.update(article_params)

    if @article.save
      flash[:notice] = "Article updated successfully."

      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy

    flash[:notice] = "Article deleted successfully."

    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && != current_user.admin?
      flash[:alert] = "You are not allowed to edit/delete this article"

      redirect_to @article
    end
  end
end
