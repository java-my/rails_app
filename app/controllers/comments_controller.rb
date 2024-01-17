class CommentsController < ApplicationController
  def create
    comment = Current.user.comments.build(comment_params)

    if comment.save
      flash[:success] = t('defaults.message.created', item: Comment.model_name.human)
      redirect_to article_path(comment.article)
    else
      flash[:danger] = t('defaults.message.not_created', item: Comment.model_name.human)
      redirect_back fallback_location: article_path(comment.article)
    end
  end

  def destroy
    @comment = Current.user.comments.find(params[:id])
    @article = Article.find(params[:article_id])
    respond_to do |format|
      @comment.destroy
        format.js
        format.html { redirect_to article_path(@article), flash: { success: t('defaults.message.destroyed', item: Comment.model_name.human) } }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(article_id: params[:article_id])
  end
end
