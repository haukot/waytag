# encoding: utf-8

class ReportPopulator < BasePopulator
  permit :source_kind, :city_id

  def create_from_tweet(tweet)
    report = Report.new(strong_params)

    report.source_text = tweet.text
    report.time = tweet.external_created_at
    report.event_kind = EventKinds.from_text tweet.text
    report.sourceable = tweet.twitter_user
    report.longitude = tweet.longitude
    report.latitude = tweet.latitude

    report.save! ? report : nil
  end

end
