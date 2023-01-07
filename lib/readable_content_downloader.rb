# typed: false
# frozen_string_literal: true

class ReadableContentDownloader
  class ReadableContentDownloadError < StandardError; end

  attr_reader :mercury_api_url

  def initialize(mercury_api_url:)
    @mercury_api_url = mercury_api_url
  end

  def download(url)
    response = HTTP.post(
      mercury_api_url,
      json: {
        url: url,
        user_agent: user_agent,
      },
    )

    raise ReadableContentDownloadError unless response.status.success?

    OpenStruct.new(response.parse)
  end

  private

  def user_agent
    [
      'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
      'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/108.0.5359.124 Safari/537.36',
      'Googlebot/2.1 (+http://www.google.com/bot.html)'
    ].sample
  end
end
