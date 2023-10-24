class PostComment < ApplicationRecord
    belongs_to :customer
    belongs_to :post_image
    
    validates :comment, presence: true, length: { maximum: 250 }
end
