# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = user.image_url.to_s.empty? ?
                  "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
                  : user.image_url.to_s
    image_tag(gravatar_url, alt: user.username, class: 'img-circle',
                            id: 'img-circle')
  end
end
