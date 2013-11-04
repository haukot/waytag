# encoding: utf-8

class ReportPopulator < BasePopulator
  permit :source_kind, :city_id

  def populate_from_twitter(tweet)
    report = Report.new(strong_params)

    report.source_text = tweet.text
    report.time = tweet.created_at
    report.sourceable = tweet.twitter_user
    report.longitude = tweet.longitude
    report.latitude = tweet.latitude

    report.event_kind = EventKinds.from_text tweet.text

    report.save! ? report : nil
  end

end
