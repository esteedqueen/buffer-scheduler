require_relative 'log_entry'

class BufferSchedule
  attr_accessor :client, :username

  def initialize(client, username)
    @client = client
    @username = username
  end

  def empty?
    LogEntry.log.info "Checking for empty in #{@username} profile"
    scheduled_tweets.total == 0
  end

  def update(tweets)
    tweets.each do |tweet_text|
      @client.create_update(
        body: {
          text:
            tweet_text.to_s,
          profile_ids: [
            profile_id.to_s
          ]
        }
      )
    end
  end

  def shuffle
    @client.shuffle_updates(profile_id, count: 9)
  end

  def scheduled_tweets
    @client.updates_by_profile_id(profile_id, status: :pending)
  end

  def profile_id
    @profile_id ||= @client.profiles.find { |k| k.formatted_username == @username }.id
  end
end
