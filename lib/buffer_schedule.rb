class BufferSchedule

  attr_accessor :client, :profile_id

  def initialize(client)
    @client = client

    # Because I already know that @happybearsoft is the first profile - can be refactored to find the profile_id by @username
    @profile_id = client.profiles.map(&:id).first
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


private

  def scheduled_tweets
    @client.updates_by_profile_id(@profile_id, { status: :pending})
  end
end