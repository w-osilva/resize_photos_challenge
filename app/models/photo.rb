require 'mini_magick'
class Photo
  include Mongoid::Document
  field :filename, type: String
  field :original, type: String
  field :thumb_large, type: String
  field :thumb_medium, type: String
  field :thumb_small, type: String

  before_create :set_filename

  def create_thumbs
    # small (320x240), medium (384x288) and large (640x480)
    tempfile = HttpService.get_to_tempfile(original)

    save_thumb(tempfile.path, "640x480") {|thumb| self.thumb_large = thumb }
    save_thumb(tempfile.path, "384x288") {|thumb| self.thumb_medium = thumb }
    save_thumb(tempfile.path, "320x240") {|thumb| self.thumb_small = thumb }

    save
  end

  def save_thumb(from, size, &block)
    ext = File.extname(filename)
    name = filename.gsub(/#{ext}/, '')
    thumb = "#{name}_#{size}#{ext}"

    image = MiniMagick::Image.open(from)
    image.resize size
    image.format "jpg"
    image.write thumb_path(thumb)

    if File.exists? thumb_path(thumb)
      block.call(thumb) if block_given?
    end
  end

  def has_thumbs?
    (
      ( thumb_small and thumb_medium and thumb_large) and
      (
        File.exist?(thumb_path(thumb_small)) and
        File.exist?(thumb_path(thumb_medium)) and
        File.exist?(thumb_path(thumb_large))
      )
    )
  end

  def thumb_path(path = nil)
    thumb_path =  Rails.root.join('public', 'thumbs')
    thumb_path = File.join(thumb_path, path) if path.present?
    thumb_path
  end

  # def image_url(path = nil)
  #   url_base =  Rails.root_url('public', 'thumbs')
  #   thumb_path = File.join(thumb_path, path) if path.present?
  #   thumb_path
  # end

  private
  def set_filename
    self.filename = File.basename(original)
  end

end
