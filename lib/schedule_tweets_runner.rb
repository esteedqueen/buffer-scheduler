require 'hbs_content'
require 'dotenv'
Dotenv.load
require_relative 'log_entry'

class ScheduleTweetsRunner
  def initialize
    HbsContent.configure(:contentful,
                         access_token: ENV['CONTENTFUL_ACCESS_TOKEN'],
                         space: ENV['CONTENTFUL_SPACE_ID'])
  end

  def run(buffer_schedule, username)
    buffer_schedule.empty? ? update_and_shuffle_buffer(buffer_schedule, username) : do_nothing(buffer_schedule)
  end

  def fetch_tweets
    advertisements = HbsContent::ListOfTweets.advertisement.tweets.map(&:text)
    random_contents = HbsContent::ListOfTweets.internal_content.tweets.map(&:text).shuffle.take(6)
    advertisements.concat(random_contents)
  end

  def update_and_shuffle_buffer(buffer_schedule, username)
    LogEntry.log.info 'Buffer was empty, fetching tweets from contentful'

    tweets = fetch_tweets

    LogEntry.log.info "Attempting to add #{tweets.count} tweets to profile"
    buffer_schedule.update(tweets)
    buffer_schedule.shuffle

    LogEntry.log.info "#{tweets.count} tweets successfully added to #{username} profile"
  end

  def do_nothing(buffer_schedule)
    LogEntry.log.info "Buffer contains #{buffer_schedule.scheduled_tweets.total} tweets, doing nothing and exiting"
  end
end
