namespace :permissions do
    desc "Fix permissions for tmp/cache"
    task fix: :environment do
      cache_dir = Rails.root.join('tmp', 'cache')
      unless Dir.exist?(cache_dir)
        puts "Creating cache directory"
        FileUtils.mkdir_p(cache_dir)
      end
      puts "Fixing permissions for tmp/cache"
      FileUtils.chmod_R(0777, cache_dir)
      puts "Permissions fixed"
    end
  end  