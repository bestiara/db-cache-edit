class CacheNode < ApplicationRecord
  extend Arrange
  include Disable

  scope :originless, -> { where(origin_id: nil) }

  belongs_to :origin, class_name: 'DatabaseNode', foreign_key: 'origin_id'
  belongs_to :parent, class_name: 'CacheNode'
  has_many :children, class_name: 'CacheNode', foreign_key: 'parent_id'

  after_create :disable!, if: -> { parent&.disabled? }
end
