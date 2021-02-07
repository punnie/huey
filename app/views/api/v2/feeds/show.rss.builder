xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @feed.title
    xml.description @feed.description
    xml.link @feed.link

    @entries.each do |entry|
      xml.item do
        xml.title entry.title
        xml.description entry.contents.fetch('content')
        xml.pubDate entry.published_date.to_s(:rfc822)
        xml.link entry.uri
        xml.guid entry.uri
      end
    end
  end
end
