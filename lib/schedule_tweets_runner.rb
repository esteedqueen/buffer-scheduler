# require 'hbs_content'
# require_relative 'custom_log'

# class ScheduleTweetsRunner
#   def initialize
#     HbsContent.configure(:contentful,
#                      access_token: ENV['CONTENTFUL_ACCESS_TOKEN'],
#                      space: ENV['CONTENTFUL_SPACE_ID'])    
#   end

#   def run(buffer_schedule, username)
#     if buffer_schedule.empty?
#       buffer_schedule.update(tweets)
#       buffer_schedule.shuffle
#       CustomLog.log.info '#{tweets.count} tweets successfully added to #{username} profile'
#     else
#       CustomLog.log.info 'Buffer was empty, fetching tweets from contentful'
#     end
#   end

#   def tweets
#     CustomLog.log.info 'Buffer was empty, fetching tweets from contentful'

#     advertisements = HbsContent::ListOfTweets.advertisement.tweets.map(&:text)
#     random_contents = HbsContent::ListOfTweets.internal_content.tweets.map(&:text).shuffle.take(6)
#     CustomLog.log.info 'Attempting to add 8 tweets to #{username} profile'
#     return advertisements.concat(random_contents)   
#   end
# end
