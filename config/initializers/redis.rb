require 'connection_pool'
require 'redis-objects'

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) { Redis.new(:host => '127.0.0.1', :port => 6379) }
$redis = Redis::Objects.redis