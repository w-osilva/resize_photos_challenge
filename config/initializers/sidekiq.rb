# setup pid file
pids_path =  Rails.root.join('tmp', 'pids')
FileUtils.mkdir_p(pids_path) unless File.directory?(pids_path)

sidekiq_pid_file = File.join(pids_path, 'sidekiq.pid')
File.open(sidekiq_pid_file, 'w'){|f|} unless File.file?(sidekiq_pid_file)