# frozen_string_literal: true

require 'test_helper'

class RssFeedFetcherTest < ActiveSupport::TestCase
  test 'parse techememe.com feed' do
    feed = RssFeed.new
    Fetchers::RssFeedFetcher.new(feed: feed).parse(feed_content('www.techmeme.com', 'feed.xml'))

    assert feed.title == 'Techmeme'
    assert feed.entries.count == 15

    assert feed.entries.first.title == "As the use of AI-generated ads in political campaigns increases, lawmakers, political consultants, and election researchers push for creating new guardrails (New York Times)"
    assert feed.entries.first.link == 'http://www.techmeme.com/230625/p9#a230625p9'
    assert feed.entries.first.uri == 'http://www.techmeme.com/230625/p9#a230625p9'
  end

  test 'parse publico.pt feed' do
    feed = RssFeed.new
    Fetchers::RssFeedFetcher.new(feed: feed).parse(feed_content('www.publico.pt', 'PublicoRSS'))

    assert feed.title == 'PÚBLICO'
    assert feed.entries.count == 10

    assert feed.entries.first.title == 'Rio mau e Montenegro bom? O problema é o “guru económico” dos dois, diz Costa'
    assert feed.entries.first.link == 'https://www.publico.pt/2023/06/25/politica/noticia/rio-mau-montenegro-bom-problema-guru-economico-dois-costa-2054602'
    assert feed.entries.first.uri == 'https://www.publico.pt/2023/06/25/politica/noticia/rio-mau-montenegro-bom-problema-guru-economico-dois-costa-2054602'
  end

  def feed_content(*path)
    File.read(Rails.root.join('test', 'fixtures', 'files', *path))
  end
end
