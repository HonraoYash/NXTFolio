# frozen_string_literal: true

class MockRedis
  def initialize
    @dirname = 'local_redis'
  end

  def _create_dir
    return if File.directory?(@dirname)

    puts 'creating dir'
    FileUtils.mkdir_p(@dirname)
  end

  def set(name, content)
    _create_dir
    File.open(File.join(@dirname, name), 'w') do |file|
      file.puts content
    end
  end

  def del(name)
    _create_dir
    FileUtils.rm(File.join(@dirname, name))
  end

  def get(name)
    _create_dir
    begin
      File.read(File.join(@dirname, name))
    rescue StandardError
      ''
    end
  end
end

if ENV['REDIS_URL'].nil? || ENV['REDIS_URL'].empty?
  puts 'Redis Host: local filesystem'
  $redis = MockRedis.new
else
  puts "Redis Host: #{ENV['REDIS_URL']}"
  $redis = Redis.new(url: ENV['REDIS_URL'])
end
