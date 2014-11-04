class VkBotWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(text, author, time, id)
    event_kind = EventKinds.from_text text

    return unless event_kind

    report = Report.new

    report.source_text = text
    report.time = time
    report.event_kind = event_kind
    report.city = City.find_by(slug: :ul)
    report.source_kind = :vk

    if id
      sourceable = VkUser.find_or_create_by(vk_id: id)

      if sourceable.name != author
        sourceable.name = author
        sourceable.save
      end

      report.sourceable = sourceable
    end

    report.save

    ReportsWorker.perform_async(report.id)
  end
end
