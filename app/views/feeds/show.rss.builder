xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', 'xmlns:atom': 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title @feed.title
    xml.description @feed.description
    xml.link @feed.link
    xml.tag! 'atom:link', rel: 'self', type: 'application/rss+xml', href: api_v2_feed_url(@feed, format: :rss)

    @entries.each do |entry|
      xml.item do
        xml.title entry.title
        xml.description entry.contents.fetch('content')
        xml.pubDate entry.published_date.to_fs(:rfc822)
        xml.link entry.real_uri
        xml.guid entry.uuid
      end
    end
  end
end
