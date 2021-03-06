require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'buffer'

require_relative '../lib/buffer_schedule'
require_relative '../lib/schedule_tweets_runner'

require 'json'
require 'ostruct'

# Mocks of some of the Buffer API responses
def scheduled_tweets_response
  JSON.parse('{ "total": 9, "updates": [ { } ] }', object_class: OpenStruct)
end

def profiles
  JSON.parse('[{"id": 2, "formatted_username": "@joy"}]', object_class: OpenStruct)
end

def shuffle_response
  JSON.parse('{"success": true, "updates": [], "time_to_shuffle":0.0041220188140869}')
end

def update_response
  JSON.parse('{"success": true, "buffer_count": 9, "updates": []}')
end
