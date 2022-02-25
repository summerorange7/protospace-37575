class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments#ビューファイルの内容良ければモデルのアソシエーション確認
      render "prototypes/show"
    end
  end


  private

  def comment_params#ストロングパラ＝受け取り機能　パスから送られたidを受け取る
  params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
