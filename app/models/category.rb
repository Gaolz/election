class Category < ApplicationRecord
    after_create :init_score

    has_many :items

    include Redis::Objects
    sorted_set :vote, :global => true
    counter :hit # 浏览次数

    def score
        Category.vote.score(id).to_i
    end

    def rank
        Category.vote.revrank(id).next
    end

    private
        def init_score
            Category.vote[id] = 0
        end
end
