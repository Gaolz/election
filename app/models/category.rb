class Category < ApplicationRecord
    has_many :items

    include Redis::Objects
    sorted_set :vote, :global => true
    counter :hit # 浏览次数

    def score
        Category.vote.score(id).to_i
    end

    def rank
        Category.vote.rank(id)
    end
end
