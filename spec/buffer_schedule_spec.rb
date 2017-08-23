require 'spec_helper'

describe BufferSchedule do
  let(:buffer_client) { instance_double('Buffer::Client') }
  let(:twitter_username) { '@joy' }
  let(:profile_id) { 2 }

  it '.profile_id' do
    setup
    response = BufferSchedule.new(buffer_client, twitter_username)

    expect(response.profile_id).to eq 2
  end

  it '.scheduled_tweets' do
    setup
    allow(buffer_client).to receive(:updates_by_profile_id)
      .with(profile_id, status: :pending)
      .and_return(scheduled_tweets)

    response = BufferSchedule.new(buffer_client, twitter_username).scheduled_tweets

    expect(response).to eq scheduled_tweets
  end

  it '.empty?' do
    buffer_schedule = instance_double('BufferSchedule')
    allow(buffer_schedule).to receive(:scheduled_tweets).and_return(scheduled_tweets)
    allow(buffer_schedule).to receive(:empty?).and_return(scheduled_tweets['total'] == 0)

    expect(buffer_schedule.empty?).to eq false
  end

  it '.update' do
    setup
    tweets = ['hey']
    allow(buffer_client).to receive(:create_update).with(
      body: {
        text:
          tweets[0],
        profile_ids: [profile_id.to_s]
      }
    )

    response = BufferSchedule.new(buffer_client, twitter_username).update(tweets)

    expect(response).to eq tweets
  end

  it '.shuffle' do
    setup
    allow(buffer_client).to receive(:shuffle_updates).with(profile_id, count: 9).and_return(shuffle_response)

    response = BufferSchedule.new(buffer_client, twitter_username).shuffle

    expect(response).to eq shuffle_response
  end

  def setup
    allow(buffer_client).to receive(:profiles).and_return(profiles)
  end
end
