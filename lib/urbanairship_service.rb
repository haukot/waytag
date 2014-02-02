class UrbanairshipService
  class << self
    def push(report)
      AndroidUser.with_push_token.find_in_batches(batch_size: 25) do |batch|
        push_tokens = batch.map(&:push_token)

        notification = {
          apids: push_tokens,
          android: { alert: report.clean_text }
        }
        Urbanairship.push(notification)
      end
    end
  end
end
