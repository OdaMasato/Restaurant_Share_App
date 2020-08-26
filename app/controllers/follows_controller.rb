class FollowsController < ApplicationController

  def index

    # ログイン中ユーザが登録しているフォロワーのuser情報を取得
    follows_id = Follow.where(user_id: current_user.id)
    @follows = []

    # followsのuser情報を取得し配列に格納
    follows_id.each do |follow_id|
      follow = User.new
      follow = follow_id.user
      @follows << follow
    end
  end
  
  def create
    # パラメータからフォロー対象のユーザーIDを取得
    follow_user_id = params[:id]

    follow = Follow.new()
    follow.user_id = current_user.id
    follow.follow_id = follow_user_id

    # ☆エラー処理するのが望ましい
    follow.save!
    redirect_to users_index_path
  end

  def show
    @user = User.new()
    @user.id = params[:id]
    @user.account_id = params[:account_id]
    @user.account_name = params[:account_name]
    @user.image = params[:image]

    if (Follow.exists?(user_id: current_user.id, follow_id: @user.id))
      @follow_user_reg = true
    else
      # nop
      @follow_user_reg = false
    end
  end

  def destroy

    user_id = current_user.id
    follow_id = params[:id]

    # MarkRestaurantTableのレコード削除
    follow = Follow.find_by(user_id: user_id, follow_id: follow_id)
    follow.destroy!

    redirect_to users_index_path
  end
end
