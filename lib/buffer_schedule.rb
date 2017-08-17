class BufferSchedule

  attr_accessor :client, :profile_id, :username

  def initialize(client, username)
    @client = client
    @username = username
    @profile_id = client.profiles.select { | key| key.formatted_username == @username }.map(&:id)
  end

  def is_empty?
    scheduled_tweets.total == 0
  end  

  def update(tweets)
    tweets.each do |tweet_text|
      client.create_update(
        body: {
          text:
            "#{tweet_text}",
          profile_ids: [
            "#{@profile_id}"
          ]
        },
      )
    end
  end

  def shuffle
    @client.shuffle_updates(@profile_id, {})   
  end

  def scheduled_tweets
    @client.updates_by_profile_id(@profile_id, { status: :pending})
  end
end