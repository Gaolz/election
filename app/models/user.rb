class User < ApplicationRecord
    include Redis::Objects

    set :voted_items
end
