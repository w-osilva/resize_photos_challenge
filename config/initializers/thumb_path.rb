# setup thumb directory
thumb_path =  Rails.root.join('public', 'thumbs')
FileUtils.mkdir_p(thumb_path) unless File.directory?(thumb_path)