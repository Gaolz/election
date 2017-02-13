class Item < ApplicationRecord
    mount_uploader :avatar, AvatarUploader

    belongs_to :category

    def media_name
        media == 1 ? '微信' : '微博'
    end

    def category_name
        category&.name
    end
end
