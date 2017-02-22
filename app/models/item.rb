class Item < ApplicationRecord
    after_save :init_score

    mount_uploader :avatar, AvatarUploader

    include Redis::Objects
    sorted_set :wechat_vote, global: true
    sorted_set :weibo_vote, global: true
    counter :hit # 浏览次数

    belongs_to :category

    scope :wechat, -> { where(media: 1) }
    scope :weibo, -> { where(media: 2) }

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

    def add_score(user=User.first)
        wechat? ? wechat_add_score(user) : weibo_add_score(user)
    end

    def wechat_add_score(user)
        Item.wechat_vote.incr(id)
        Category.vote.incr(category_id)
        user.voted_items << id
    end

    def weibo_add_score(user)
        Item.weibo_vote.incr(id)
        Category.vote.incr(category_id)
        user.voted_items << id
    end

    def media_name
        wechat? ? '微信' : '微博'
    end

    def category_name
        category&.name
    end

    private
        def init_score
            wechat? ? Item.wechat_vote[id] = 0 : Item.weibo_vote[id] = 0
        end
end
