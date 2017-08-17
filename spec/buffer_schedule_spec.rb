require 'spec_helper'
require 'json'
require 'ostruct'

describe BufferSchedule do
  let(:buffer_client) { instance_double("Buffer::Client")}
  let(:twitter_username) { "@joy"}
  let(:buffer_schedule) { instance_double("BufferSchedule")}
  let(:scheduled_tweets) { JSON.parse('{ "total": 3, "updates": [ { } ] }', object_class: OpenStruct) }

  it 'returns scheduled tweets' do
    profiles = JSON.parse('[{"id": 2, "formatted_username": "@joy"}]', object_class: OpenStruct)

    allow(buffer_client).to receive(:profiles).and_return(profiles)
    allow(buffer_client).to receive(:updates_by_profile_id).with([2], { status: :pending}).and_return(scheduled_tweets)

    response = BufferSchedule.new(buffer_client, twitter_username).scheduled_tweets

    expect(response).to eq scheduled_tweets
  end  

  it '.is_empty?' do
    allow(buffer_schedule).to receive(:scheduled_tweets).and_return(scheduled_tweets)
    allow(buffer_schedule).to receive(:is_empty?).and_return( scheduled_tweets["total"] == 0)

    expect(buffer_schedule.is_empty?).to eq false
  end

  it '.update' do
    # puts "updates buffer"

  end

  it '.shuffle' do
  end

end