class DatabaseNode < ApplicationRecord
  extend Arrange
  include Disable

  belongs_to :parent, class_name: 'DatabaseNode'
  has_many :children, class_name: 'DatabaseNode', foreign_key: 'parent_id'
  has_one :clone, class_name: 'CacheNode', foreign_key: 'origin_id'

  validates_with CantUpdateDisabledValidator
end
