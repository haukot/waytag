class VkBotWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(text, author, time)
    event_kind = EventKinds.from_text text

    if event_kind
      report = Report.new

      report.source_text = text
      report.time = time
      report.event_kind = event_kind
      report.city = City.find_by(slug: :ul)
      report.source_kind = :vk

      report.save

      p report.errors
      ReportsWorker.perform_async(report.id)
    end
  end
end
