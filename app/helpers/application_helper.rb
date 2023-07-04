module ApplicationHelper
  AVATAR_STYLES = %w[marble beam pixel sunset bauhaus].freeze

  def img_src_for_entry(entry)
    if entry.readable_content && entry.readable_content.dig('table', 'lead_image_url').present?
      entry.readable_content.dig('table', 'lead_image_url')
    else
      "https://source.boringavatars.com/#{AVATAR_STYLES[entry.feed.id % AVATAR_STYLES.length]}/120/#{entry.feed.id}?colors=264653,2a9d8f,e9c46a,f4a261,e76f51&square=true"
    end
  end
end
