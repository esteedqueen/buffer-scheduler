require 'spec_helper'

describe ScheduleTweetsRunner do
  let(:tweets) { %w[jane ade] }
  let(:twitter_username) { '@joy' }

  context 'buffer schedule is empty' do
    it 'runs the buffer schedule updates' do
      buffer_schedule = instance_double('BufferSchedule', empty?: true)

      allow(buffer_schedule).to receive(:update).with(tweets)
      allow(buffer_schedule).to receive(:shuffle)

      schedule_tweets = ScheduleTweetsRunner.new
      allow(schedule_tweets).to receive(:tweets).and_return(tweets)

      schedule_tweets.run(buffer_schedule, twitter_username)

      expect(buffer_schedule).to have_received(:update).with(schedule_tweets.tweets)
      expect(buffer_schedule).to have_received(:shuffle)
    end
  end
  context 'buffer schedule is not empty' do
    it 'does nothing' do
      buffer_schedule = instance_double('BufferSchedule', empty?: false)

      allow(buffer_schedule).to receive(:update).with(tweets)
      allow(buffer_schedule).to receive(:shuffle)
      allow(buffer_schedule).to receive(:scheduled_tweets).and_return(tweets)

      schedule_tweets = ScheduleTweetsRunner.new

      schedule_tweets.run(buffer_schedule, tweets)

      expect(buffer_schedule).not_to have_received(:update).with(tweets)
      expect(buffer_schedule).not_to have_received(:shuffle)
    end
  end
end
