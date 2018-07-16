require "spec_helper"

RSpec.describe Historedis, '#increment' do
  before do
    @redis = Redis.new
    @historedis = Historedis.new
    @redis.flushall
  end

  context 'without any options' do
    it 'should increment the value stored in the key' do
      @historedis.increment('hello', 'field1')
      expect(@redis.hget('hello', 'field1')).to eql('1')

      @historedis.increment('hello', 'field1')
      expect(@redis.hget('hello', 'field1')).to eql('2')
    end

    it 'should not set an expiry on the key' do
      @historedis.increment('hello', 'field1')
      expect(@redis.ttl('hello')).to eql(-1)
    end
  end

  context 'with keep_data_for option' do
    it 'should set an expiry on the key' do
      @historedis.increment('hello', 'field1', keep_data_for: 12.hours)
      expect(@redis.hget('hello', 'field1')).to eql('1')
      expect(@redis.ttl('hello')).to eql(43200)
    end
  end
end

RSpec.describe Historedis, '#distribution' do
  before do
    @redis = Redis.new
    @historedis = Historedis.new
    @redis.flushall
  end

  it 'should return a distribution of counts' do
    @historedis.increment('hello', 'field1')
    @historedis.increment('hello', 'field1')
    @historedis.increment('hello', 'field2')
    @historedis.increment('hello', 'field3')
    # field2 and field3 both have a value 1, so '1' has 2 objects
    # field1 has the value 2, so in the distribution, '2' has 1 object
    expect(@historedis.distribution('hello')).to eql({ 1 => 2, 2 => 1 })
  end
end
