class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  #authen使ってログインしていない場合はログインページへ誘導 

  def index
    #ログインしている人だけ見られるようにここで設定
    #if user_signed_in?：ログインしないと・・・
    #ただし、ここで設定するとログアウトしたら全て消える
    @prototypes = Prototype.all
    #end
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(proto_params)
    if @prototype.save
      redirect_to root_path #redirect_toあり：indexアクションに移動してindexのビューファイルを表示
    else
      render :new 
      #renderあり:（現在いる）createアクションの一環としてnewのビューファイルを見る
      #newのビューファイルでは:@prototypeにフォーム入力時に入れた情報をそのまま引き継げる
      #_form:↑で引き継がれた情報をそのまま入れる→見た目(ビュー)的に変化なし
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)#プロトタイプに紐づくコメントを入れる
  end

  def edit
    @prototype = Prototype.find(params[:id]) 
    unless current_user.id == @prototype.user_id #投稿者かどうかの分岐
      redirect_to action: :index
    end
    
   
  end

  def update
    @prototype = Prototype.find(params[:id])
    # @newproto = @prototype.update(proto_params)
    if @prototype.update(proto_params)
      redirect_to  prototype_path(@prototype)
    else
      render :edit
    end
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def proto_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)

  end

end
