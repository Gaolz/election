class Item < ApplicationRecord
    after_save :init_score

    mount_uploader :avatar, AvatarUploader

    include Redis::Objects
    sorted_set :wechat_vote, global: true
    sorted_set :weibo_vote, global: true
    set :voted_user
    counter :hit # 浏览次数

    belongs_to :category

    scope :wechat, -> { where(media: 1) }
    scope :weibo, -> { where(media: 2) }

    def is_voted_by_user?(user_id)
        voted_user.member? user_id
    end

    def self.wechat_revrange
        wechat_vote.revrange(0, -1)
    end

    def self.weibo_revrange
        weibo_vote.revrange(0, -1)
    end

    def wechat?
        media == 1
    end

    def score
        wechat? ? wechat_score : weibo_score
    end

    def wechat_score
        Item.wechat_vote.score(id).to_i
    end

    def weibo_score
        Item.weibo_vote.score(id).to_i
    end

    def rank
        wechat? ? wechat_rank : weibo_rank
    end

    def wechat_rank
        Item.wechat_vote.revrank(id).next
    end

    def weibo_rank
        Item.weibo_vote.revrank(id).next
    end

    def add_score(user_id=1)
        wechat? ? wechat_add_score(user_id) : weibo_add_score(user_id)
    end

    def wechat_add_score(user_id)
        Item.wechat_vote.incr(id)
        Category.vote.incr(category_id)
        voted_user.add(user_id)
    end

    def weibo_add_score(user_id)
        Item.weibo_vote.incr(id)
        Category.vote.incr(category_id)
        voted_user.add(user_id)
    end

    def hit_value
        hit.value
    end

    def hit_incr
        hit.incr
    end

    def category_name
        category&.name
    end

    private
        def init_score
            wechat? ? Item.wechat_vote[id] = 0 : Item.weibo_vote[id] = 0
        end
end
