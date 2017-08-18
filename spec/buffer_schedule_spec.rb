require 'spec_helper'

describe BufferSchedule do
  let(:buffer_client) { instance_double("Buffer::Client")}
  let(:twitter_username) { "@joy"}
  let(:profile_id) { profiles.find { |k| k.formatted_username == twitter_username }.id }

  it '#scheduled_tweets' do
    setup
    allow(buffer_client).to receive(:updates_by_profile_id)
      .with(profile_id, { status: :pending})
      .and_return(scheduled_tweets)

    response = BufferSchedule.new(buffer_client, twitter_username).scheduled_tweets

    expect(response).to eq scheduled_tweets
  end  

  it '#is_empty?' do
    buffer_schedule = instance_double("BufferSchedule")
    allow(buffer_schedule).to receive(:scheduled_tweets).and_return(scheduled_tweets)
    allow(buffer_schedule).to receive(:is_empty?).and_return( scheduled_tweets["total"] == 0)

    expect(buffer_schedule.is_empty?).to eq false
  end

  it '#update' do
    setup
    tweets = ["hey"]
    allow(buffer_client).to receive(:create_update).with(
        body: {
          text:
            tweets[0],
          profile_ids: ["#{profile_id}"]
        }     
      )

    response = BufferSchedule.new(buffer_client, twitter_username).update(tweets)

    expect(response).to eq tweets

  end

  it '#shuffle' do
    setup
    allow(buffer_client).to receive(:shuffle_updates).with(profile_id, {}).and_return(shuffle_response)

    response = BufferSchedule.new(buffer_client, twitter_username).shuffle

    expect(response).to eq shuffle_response

  end

  def setup
    allow(buffer_client).to receive(:profiles).and_return(profiles)    
  end

end