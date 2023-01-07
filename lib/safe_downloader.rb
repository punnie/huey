# typed: false
# frozen_string_literal: true

class SafeDownloader
  class SafeDownloadError < StandardError; end

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

    raise SafeDownloadError unless response.status.success?

    response.body.each do |chunk|
      break if content_size > max_size || chunk.nil?

      content << chunk
      content_size += chunk.size
    end

    content
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
