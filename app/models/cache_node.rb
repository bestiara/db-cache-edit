class CacheNode < ApplicationRecord
  extend Arrange
  include Disable

  scope :originless, -> { where(origin_id: nil) }

  belongs_to :origin, class_name: 'DatabaseNode', foreign_key: 'origin_id'
  belongs_to :parent, class_name: 'CacheNode'
  has_many :children, class_name: 'CacheNode', foreign_key: 'parent_id'

  validates_with CantUpdateDisabledValidator
  validates_with CantAddChildToDisabledValidator

  after_create :disable_deep!, if: -> { parent&.disabled? }
end
