class PostComment < ApplicationRecord
    belongs_to :customer
    belongs_to :post_image
    
    # 最大250文字まで
    validates :comment, presence: true, length: { maximum: 250 }
end
