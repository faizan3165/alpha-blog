module ApplicationHelper
  def libravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase

    hash = Digest::MD5.hexdigest(email_address)

    size = options[:size]

    image_src = "https://seccdn.libravatar.org/avatar/#{hash}?s=#{size}"

    image_tag(image_src, alt: user.username, class: "rounded-pill shadow mx-auto d-block my-4")
  end
end
  