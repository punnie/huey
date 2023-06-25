# frozen_string_literal: true

require 'test_helper'

class AtomFeedFetcherTest < ActiveSupport::TestCase
  test 'parse theregister.com feed' do
    feed = AtomFeed.new
    Fetchers::AtomFeedFetcher.new(feed: feed).parse(feed_content('www.theregister.com', 'headlines.atom'))

    assert feed.title == 'The Register'
    assert feed.entries.count == 50

    assert feed.entries.first.title == 'FYI: Tor Browser is very much still a thing and getting updates'
    assert feed.entries.first.link == 'https://go.theregister.com/feed/www.theregister.com/2023/06/25/tor_browser_update_improves_interface/'
    assert feed.entries.first.uri == 'tag:theregister.com,2005:story228373'
  end

  test 'parse hugopeixoto.net feed' do
    feed = AtomFeed.new
    Fetchers::AtomFeedFetcher.new(feed: feed).parse(feed_content('hugopeixoto.net', 'articles.xml'))

    assert feed.title == "Hugo Peixoto's blog"
    assert feed.entries.count == 83

    assert feed.entries.first.title == 'Status update, January and February 2023'
    assert feed.entries.first.link == 'https://hugopeixoto.net/articles/status-update-2023-01-31.html'
    assert feed.entries.first.uri == 'tag:hugopeixoto.net,2023-02-19:/articles/status-update-2023-01-31.html'
  end

  test 'parse brandur.org feed' do
    feed = AtomFeed.new
    Fetchers::AtomFeedFetcher.new(feed: feed).parse(feed_content('brandur.org', 'articles.atom'))

    assert feed.title == 'Articles — brandur.org' 
    assert feed.entries.count == 20

    assert feed.entries.first.title == "Soft Deletion Probably Isn't Worth It"
    assert feed.entries.first.link == 'https://brandur.org/soft-deletion'
    assert feed.entries.first.uri == 'tag:brandur.org,2022-07-19:soft-deletion'
  end

  def feed_content(*path)
    File.read(Rails.root.join('test', 'fixtures', 'files', *path))
  end
end
