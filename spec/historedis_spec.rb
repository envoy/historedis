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
