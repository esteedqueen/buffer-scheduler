require 'logger'
require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require 'dotenv'
Dotenv.load

class LogEntry
  def self.log
    if @logger.nil?
      @logger = Logger.new 'debug.log'
      @logger.level = Logger::DEBUG
      @logger.formatter = proc do |_severity, datetime, _progname, msg|
        date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
        "[ #{date_format} ] #{msg}\n"
      end
    end
    @logger
  end

  def self.send_to_zapier(log_output)
    url = URI(ENV['ZAPIER_LOG_OUTPUT_WEBHOOK'])

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/json'
    request.body = { buffer_scheduler_log_output: log_output.to_s }.to_json
    response = JSON.parse(http.request(request).body)
    File.delete('debug.log') if response['status'] == 'success'
  end
end
