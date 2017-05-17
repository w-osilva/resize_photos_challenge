class PhotoJob < ApplicationJob
  queue_as :default


  def perform(**args)
    image = args[:image]

    # transaction not suported by mongoid
    photo = Photo.find_or_create_by(original: image['url'])
    photo.create_thumbs unless photo.has_thumbs?
  end

end
