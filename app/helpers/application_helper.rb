module ApplicationHelper
  def root_url
    request.base_url
  end

  def thumb_url(thumb = nil)
    thumb_url = File.join(root_url, 'thumbs')
    thumb_url = File.join(thumb_url, thumb) if thumb.present?
    thumb_url
  end
end
