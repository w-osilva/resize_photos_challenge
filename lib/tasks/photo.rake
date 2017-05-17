namespace :photo do

  desc 'Import photos from webservice'
  task import: :environment do
    WEBSERVICE = YAML.load_file(Rails.root.join('config', 'photo_service.yml'))

    begin
      response = HttpService.get("#{WEBSERVICE['url']}#{WEBSERVICE['resources']['images']}")

      response['images'].each do |image|
        puts "Sending to worker: #{image['url']}"
        PhotoJob.perform_later(image: image)
      end

    rescue => e
      puts e.message
      e.backtrace.each{|line| puts line}
    end

  end

end
