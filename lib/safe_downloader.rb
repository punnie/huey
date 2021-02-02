# typed: false
# frozen_string_literal: true

class SafeDownloader
  attr_reader :max_size, :max_hops

  def initialize(max_size: 10 * 1024 * 1024, max_hops: 30)
    @max_size = max_size
    @max_hops = max_hops
  end

  def download(url)
    content = String.new
    content_size = 0

    response = HTTP.headers(user_agent: user_agent)
      .follow(max_hops: max_hops)
      .get(url)

    while content_size < max_size
      chunk = response.body.readpartial
      break if chunk.nil?

      content << chunk
      content_size += chunk.size
    end

    content
  end

  private

  def user_agent
    [
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.96 Safari/537.36',
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.96 Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 11.1; rv:85.0) Gecko/20100101 Firefox/85.0',
      'Mozilla/5.0 (X11; Linux i686; rv:85.0) Gecko/20100101 Firefox/85.0',
      'Mozilla/5.0 (Linux x86_64; rv:85.0) Gecko/20100101 Firefox/85.0',
      'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:85.0) Gecko/20100101 Firefox/85.0',
      'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:85.0) Gecko/20100101 Firefox/85.0',
      'Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:85.0) Gecko/20100101 Firefox/85.0',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.2 Safari/605.1.15',
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36 Edg/88.0.705.56',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36 Edg/88.0.705.56',
    ].sample
  end
end
