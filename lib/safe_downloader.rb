# frozen_string_literal: true

class SafeDownloader
  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:80.0) Gecko/20100101 Firefox/80.0'
  MAX_SIZE = 10 * 1024 * 1024

  def safe_download(url, max_hops: 30)
    content = String.new
    content_size = 0

    response = HTTP.headers(user_agent: USER_AGENT)
      .follow(max_hops: max_hops)
      .get(url)

    while content_size < MAX_SIZE
      chunk = response.body.readpartial
      break if chunk.nil?

      content << chunk
      content_size += chunk.size
    end

    content
  end
end
