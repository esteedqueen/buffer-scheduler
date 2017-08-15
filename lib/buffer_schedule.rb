class BufferSchedule

  attr_accessor :client, :profile_id

  def initialize(client)
    @client = client
    @profile_id = client.profiles[0].id
  end

  def update(advertisement, random_content)
    puts "is_empty" * 5
    puts is_empty?
  end

  def shuffle
    
  end


private

  def scheduled_tweets
    @client.updates_by_profile_id(@profile_id, { status: :pending})
  end

  def is_empty?
    scheduled_tweets.total == 0
  end
  

end