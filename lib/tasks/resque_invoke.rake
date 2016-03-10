namespace :resque_invoke do
  task enqueue_jobs: :environment do
    Resque.enqueue(PrintRandomJob)
    Resque.enqueue(PrintPersonJob)
    Resque.enqueue(PrintCompanyJob)
  end
end
