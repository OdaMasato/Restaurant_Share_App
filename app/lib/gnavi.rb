class Gnavi

  # [概　要] HTTPレスポンス取得(JSON)
  # [引　数] URL
  # [戻り値] 正常完了:ハッシュしたjsonデータ / 正常完了以外:nil
  # [説　明] 引数のURLでHTTPリクエストを行い、レスポンスとして取得したjsonデータをハッシュ化して返す
  def self.get_http_res_json(url, limit = 10)

    # リダイレクトがlimitを超えた場合、ランタイムエラーを発生
    raise ArgumentError, 'too many HTTP redirects' if limit == 0

    # URLをURIにエンコード
    url=URI.encode(url)

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