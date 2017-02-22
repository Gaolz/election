class User < ApplicationRecord
    include Redis::Objects

    set :voted_items

    def is_voted_the_item?(item_id)
        voted_items.include? item_id
    end
end
