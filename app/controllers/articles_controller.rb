class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find_by(id: [params[:id]])
    if @article.nil?
      flash[:danger] = "記事が見つかりませんでした。"
      redirect_to root_path
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "記事が作成できました。"
      redirect_to @article
    else
      flash[:danger] = "記事の作成が失敗しました。もう一度試してください。"
      render :new
    end
  end

  def edit
    @article = Article.find_by(id: [params[:id]])
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
    @article = Article.find_by(id: [params[:id]])
    @article.destroy
    flash[:success] = "投稿が削除されました。"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
