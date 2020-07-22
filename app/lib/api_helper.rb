module ApiHelper

  # [概　要] HTTPレスポンス取得(JSON)
  # [引　数] URL
  # [戻り値] 正常完了:ハッシュしたjsonデータ / 正常完了以外:nil
  # [説　明] 引数のURLでHTTPリクエストを行い、レスポンスとして取得したjsonデータをハッシュ化して返す
  def get_http_res_json(url, limit = 10)

    # リダイレクトがlimitを超えた場合、ランタイムエラーを発生
    raise ArgumentError, 'too many HTTP redirects' if limit == 0

    # URLをURIにエンコード
    url=URI.encode(url)

    # URIクラスのインスタンスを生成
    uri = URI.parse(url)

    # errorキャッチ開始
    begin
      # ☆宣言していないhttpで回しているがどこから出てきた？
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.open_timeout = 5
        http.read_timeout = 10
        http.get(uri.request_uri)
      end

      case response
        when Net::HTTPSuccess
          # 正常完了した場合
          # ☆jsonをhash化しているがその理由は？
          json = response.body
          JSON.parse(json)
        when Net::HTTPRedirection
          # リダイレクトが発生した場合
          url = response['url']
          warn "redirected to #{url}"
          get_json(url, limit - 1)
        else
          # 上記以外の場合
          # URIとレスポンス結果を出力
          puts [uri.to_s, response.value].join(" : ")
          nil
      end
    rescue => e
      # error内容を出力
      puts [uri.to_s, e.class, e].join(" : ")
      nil
    end
  end
end