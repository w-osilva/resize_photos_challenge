class ResizeJob < ApplicationJob
  queue_as :default


  def perform(*args)

    test_file = Rails.root.join('log', 'test.txt')

    File.open(test_file, 'a+') do |f|
      f.puts("#{Time.now} - #{args}")
    end

  end

end
