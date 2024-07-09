namespace :test do
    desc "Clear temporary files before running tests"
    task :cleanup do
      Rake::Task['tmp:cache:clear'].invoke
      Rake::Task['tmp:clear'].invoke
    end
  end  