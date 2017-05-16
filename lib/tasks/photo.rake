namespace :photo do

  desc 'Import photos from webservice'
  task import: :environment do
    WEBSERVICE = YAML.load_file(Rails.root.join('config', 'photo_service.yml'))

    begin
      response = HttpService.get("#{WEBSERVICE['url']}#{WEBSERVICE['resources']['images']}")

      response['images'].each do |image_url|
        # Next if the image already exists

        # Download original

        # Create record

        # Generate thumbs
        ResizeJob.perform_later(image_url)
      end

    rescue => e
      puts "#{Time.now} - #{e.message}"
      e.backtrace.each{|line| puts line}
    end

  end

end
