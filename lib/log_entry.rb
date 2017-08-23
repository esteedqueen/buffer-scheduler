require 'logger'
require 'dotenv'
Dotenv.load

class LogEntry
  def self.log
    if @logger.nil?
      @logger = Logger.new 'debug.log'
      @logger.level = Logger::DEBUG
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S %Z '
    end
    @logger
  end

  def self.send_to_zapier(log_output)
    response = HTTParty.post(ENV['ZAPIER_LOG_OUTPUT_WEBHOOK'],
                             body: { buffer_scheduler_log_output: log_output.to_s }).parsed_response
    File.delete('debug.log') if response['status'] == 'success'
  end
end
