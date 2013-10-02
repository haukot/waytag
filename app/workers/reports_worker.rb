class ReportsWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(name, count)
    puts name, count
  end
end
