class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :slug, presence: true
    validates_uniqueness_of :slug

    scope :recent, -> {order(created_at: :desc)}
end
