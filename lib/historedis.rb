class Historedis
  VERSION = '0.1.0'

  def initialize(redis_url = nil)
    @redis = Redis.new(url: redis_url)
  end

  def increment(key, field, opts = {})
    response = @redis.hincrby(key, field, 1)

    if (keep_data_for = opts[:keep_data_for].to_i) > 0
      @redis.expire(key, keep_data_for) if @redis.ttl(key) < 0
    end
  end

  private
  attr_reader :redis
end
