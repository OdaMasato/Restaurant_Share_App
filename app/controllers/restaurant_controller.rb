class RestaurantController < ApplicationController
  require "Gnavi"

  def index
    # ぐるなびのレストラン検索APIへのURLを作成
    gnavi_url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid='

    # credentialsに登録しているアクセスキーを取得
    api_key = Rails.application.credentials.dig(:grunavi, :api_key)
    gnavi_url << api_key

    # 検索文字列とURLを連結
    word = params[:search]
    word ||= ""
    gnavi_url << "&name=" << word 

    # HTTPリクエスト及びレスポンス(json)を取得
    result = Gnavi.get_http_res_json(gnavi_url)
    @rests = result["rest"]
  end
end
