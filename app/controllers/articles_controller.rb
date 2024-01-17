class ArticlesController < ApplicationController
  before_action :user_login_required, only: %i[new create edit update destroy]
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = Article.all.includes(:user)
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find_by(id: [params[:id]])
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order(created_at: :desc)

    if @article.nil?
      flash[:danger] = "記事が見つかりませんでした。"
      redirect_to root_path
    end
  end

  def create
    @article = Current.user.articles.build(article_params)
    if @article.save
      flash[:success] = t('defaults.message.created', item: Article.model_name.human)
      redirect_to @article
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Article.model_name.human)
      render :new
    end
  end

  def edit
    unless @article.user_id == Current.user.id
      flash[:danger] = "投稿を管理する権限がありません。"
      redirect_to @article
    end
  end

  def update
    @article = Article.find_by(id: [params[:id]])
    if @article.update(article_params)
      flash[:success] = "投稿が更新されました。"
      redirect_to @article
    else
      flash[:danger] = "投稿の更新が失敗しました。もう一度試してください。"
      render :edit
    end
  end

  def destroy
    if @article.user_id == Current.user.id
      @article.destroy
      flash[:success] = "投稿が削除されました。"
      redirect_to articles_path
    else
      flash[:danger] = "投稿を管理する権限がありません。"
      redirect_to @article
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find_by(id: params[:id])
  end
end
