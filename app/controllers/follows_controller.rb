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

    follow_me = Follow.new()
    follow_me.user_id = current_user.id
    follow_me.follow_id = follow_user_id
    follow_me.follow_status = Follow::FOLLOW_STATUS_TYPE_REQUEST
    # ☆エラー処理するのが望ましい
    follow_me.save!

    follow_you = Follow.new()
    follow_you.user_id = follow_user_id
    follow_you.follow_id = current_user.id
    follow_you.follow_status = Follow::FOLLOW_STATUS_TYPE_REQUEST_TO_YOU

    # ☆エラー処理するのが望ましい
    follow_you.save!

    redirect_back(fallback_location: root_path)
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

  def update

    user_id = current_user.id
    follow_id = params[:id]

    follow_me = Follow.find_by(user_id: user_id, follow_id: follow_id)
    follow_me.update(follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING)

    follow_you =  Follow.find_by(user_id: follow_id, follow_id: user_id)
    follow_you.update(follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING)

    redirect_back(fallback_location: root_path)

  end

  def destroy

    user_id = current_user.id
    follow_id = params[:id]

    follow_me = Follow.find_by(user_id: user_id, follow_id: follow_id)
    follow_me.destroy!

    follow_you = Follow.find_by(user_id: follow_id, follow_id: user_id)
    follow_you.destroy!

    redirect_back(fallback_location: root_path)
  end
end
