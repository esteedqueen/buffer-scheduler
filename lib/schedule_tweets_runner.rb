class ScheduleTweetsRunner
  def run(buffer_schedule, tweets)
    if buffer_schedule.is_empty?
      buffer_schedule.update(tweets)
      buffer_schedule.shuffle
      puts "buffer_schedule updated and shuffled"
    else
      puts "There are tweets in the buffer_schedule"
    end    
  end
end