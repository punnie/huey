# typed: false
# frozen_string_literal: true

class ReadableContentDownloader
  class ReadableContentDownloadError < StandardError; end

  attr_reader :mercury_api_url

  def initialize(mercury_api_url:)
    @mercury_api_url = mercury_api_url
  end

  def download(url, use_googlebot_agent: true)
    response = HTTP.post(
      mercury_api_url,
      json: {
        url: url,
        user_agent: user_agent(use_googlebot_agent)
      }
    )

    raise ReadableContentDownloadError unless response.status.success?

    OpenStruct.new(response.parse)
  end

  private

  def user_agent(use_googlebot_agent)
    googlebot_user_agents.sample if use_googlebot_agent

    regular_user_agents.sample
  end

  def googlebot_user_agents
    [
      'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
      'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/108.0.5359.124 Safari/537.36',
      'Googlebot/2.1 (+http://www.google.com/bot.html)'
    ]
  end

  def regular_user_agents
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
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36 Edg/88.0.705.56'
    ]
  end
end
