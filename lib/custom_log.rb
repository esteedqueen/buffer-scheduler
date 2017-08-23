require 'logger'
class CustomLog
  def self.log
    if @logger.nil?
      @logger = Logger.new STDOUT
      @logger.level = Logger::DEBUG
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S %Z '
    end
    @logger
  end
end