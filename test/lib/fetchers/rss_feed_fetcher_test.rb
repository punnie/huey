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

  test 'parse feeds.macrumors.com feed' do
    feed = RssFeed.new
    Fetchers::RssFeedFetcher.new(feed: feed).parse(feed_content('feeds.macrumors.com', 'MacRumors-All'))

    assert feed.title == 'MacRumors: Mac News and Rumors - All Stories'
    assert feed.entries.count == 20

    assert feed.entries.first.title == 'Top Stories: visionOS SDK, iOS 17 Beta 2, and More'
    assert feed.entries.first.link == 'https://www.macrumors.com/2023/06/24/top-stories-visionos-sdk/'
    assert feed.entries.first.uri == 'https://www.macrumors.com/2023/06/24/top-stories-visionos-sdk/'
  end

  test 'parse lwn.net feed' do
    feed = RssFeed.new
    Fetchers::RssFeedFetcher.new(feed: feed).parse(feed_content('lwn.net', 'rss'))

    assert feed.title == 'LWN.net'
    assert feed.entries.count == 15

    assert feed.entries.first.title == 'Kuhn: A Comprehensive Analysis of the GPL Issues With the Red Hat Enterprise Linux (RHEL) Business Model'
    assert feed.entries.first.link == 'https://lwn.net/Articles/936127/'
    assert feed.entries.first.uri == 'https://lwn.net/Articles/936127/'
  end

  def feed_content(*path)
    File.read(Rails.root.join('test', 'fixtures', 'files', *path))
  end
end
