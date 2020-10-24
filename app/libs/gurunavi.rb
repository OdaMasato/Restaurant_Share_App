class Gurunavi

  GURUNAVI_RESTAURANT_SEARCH_URL = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid='
  GURUNAVI_RESTAURANT_SEARCH_PARAM_FREEWORD = '&freeword='
  GURUNAVI_RESTAURANT_SEARCH_PARAM_REQ_HIT_COUNT = '&hit_per_page='
  GURUNAVI_RESTAURANT_SEARCH_PARAM_REQ_HIT_COUNT_DEFAULT = 100
  GURUNAVI_RESTAURANT_SEARCH_HIT_COUNT_ZERO = 0
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_HIT_COUNT = 'total_hit_count'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_REST = 'rest'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_ID = 'id'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_CATEGORY = 'category'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_NAME = 'name'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_ADDRESS = 'address'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_IMAGE_URL = 'image_url'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_IMAGE_SHOP_IMAGE1 = 'shop_image1'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_OPENTIME = 'opentime'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_HORIDAY = 'holiday'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_PR = 'pr'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_PR_SHORT = 'pr_short'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_TEL = 'tel'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_URL = 'url'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS = 'access'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_LINE = 'line'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_STATION = 'station'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_STATION_EXIT = 'station_exit'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_WALK = 'walk'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_NOTE = 'note'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_BUDGET = 'budget'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_LATITUDE = 'latitude'
  GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_LONGITUDE = 'longitude'

  # [概　要] ぐるなびレストラン検索API フリーワード検索リクエストURL取得
  # [引　数] 検索文字列,検索結果取得件数
  # [戻り値] 検索結果レスポンス
  # [説　明] 検索文字列でぐるなびレストラン検索API フリーワード検索を行いレスポンスを返す
  def self.get_freeword_search_url(word, count)

    gurunavi_url = GURUNAVI_RESTAURANT_SEARCH_URL
    gurunavi_url << get_gurunavi_keyid
    
    # 検索文字列とURLを連結
    gurunavi_url << GURUNAVI_RESTAURANT_SEARCH_PARAM_REQ_HIT_COUNT << count.to_s

    word ||= ''
    gurunavi_url << GURUNAVI_RESTAURANT_SEARCH_PARAM_FREEWORD << word
  end

  # [概　要] HTTPレスポンス取得(JSON)
  # [引　数] URL
  # [戻り値] 正常完了:ハッシュしたjsonデータ / 正常完了以外:nil
  # [説　明] 引数のURLでHTTPリクエストを行い、レスポンスとして取得したjsonデータをハッシュ化して返す
  def self.get_http_res_json(url, limit = 10)
    # リダイレクトがlimitを超えた場合、ランタイムエラーを発生
    raise ArgumentError, 'too many HTTP redirects' if limit == 0

    # URLをURIにエンコード
    url = URI.encode(url)

    # URIクラスのインスタンスを生成
    uri = URI.parse(url)

    # errorキャッチ開始
    begin
      http = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https')
      http.open_timeout = 5
      http.read_timeout = 10
      response = http.get(uri.request_uri)

      case response
        when Net::HTTPSuccess
          # 正常完了した場合
          json = response.body
          # jsonをhash化して名前アクセスを可能とする
          JSON.parse(json)
        when Net::HTTPRedirection
          # リダイレクトが発生した場合
          url = response['url']
          warn "redirected to #{url}"
          get_json(url, limit - 1)
      else
        # 上記以外の場合
        # URIとレスポンス結果を出力
        puts [uri.to_s, response.value].join(' : ')
        nil
      end
    rescue StandardError => e
      # error内容を出力
      puts [uri.to_s, e.class, e].join(' : ')
      nil
    end
  end

  private

  # [概　要] ぐるなびアクセスキーを取得
  # [引　数] -
  # [戻り値] ぐるなびより提供されたアクセスキー(keyid)
  # [説　明] credentialsに登録しているぐるなびアクセスキーを取得
  def self.get_gurunavi_keyid
    Rails.application.credentials.dig(:gurunavi, :access_key)
  end
end
