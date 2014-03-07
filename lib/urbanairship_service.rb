class UrbanairshipService
  class << self
    def push(report)
      ApiUser.android.with_push_token.find_in_batches(batch_size: 25) do |batch|
        push_tokens = batch.map(&:push_token)

        notification = {
          apids: push_tokens,
          android: { alert: report.decorate.composed_text }
        }
        Urbanairship.push(notification)
      end
    end
  end
end
