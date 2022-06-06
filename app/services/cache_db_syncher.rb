class CacheDbSyncher
  attr_accessor :errors

  def initialize
    @errors = []
    super
  end

  def call
    ActiveRecord::Base.transaction do
      sync_new_nodes
      update_nodes
    end

    @errors.empty?
  end

  private

  def update_nodes
    CacheNode.all.each do |cache_node|
      origin = cache_node.origin
      origin.update_attribute(:value, cache_node.value)

      check_errors origin
      origin.disable_deep! if cache_node.disabled?
    end
  end

  def sync_new_nodes
    CacheNode.originless.each do |node|
      new_origin = DatabaseNode.create(value: node.value, parent_id: node.parent.origin.id)

      check_errors new_origin
      node.update_attribute(:origin_id, new_origin.id) if new_origin.persisted?
    end
  end

  def check_errors(node)
    @errors += node.errors
  end
end
