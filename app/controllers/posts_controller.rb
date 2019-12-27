class PostsController < ApplicationController

  def new
    @post = Post.new #フォーム用の空のインスタンスを引数に
  end
  
  def create
    @post.save #saveをしてデータベースに保存する。
    redairect_to @post #showページにリダイレクト
  end

  private

  def post_params #ストロングパラメータを定義する
    params.require(:post).permit(:caption)
  end
end
