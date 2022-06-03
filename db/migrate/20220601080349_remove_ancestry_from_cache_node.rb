class RemoveAncestryFromCacheNode < ActiveRecord::Migration[7.0]
  def change
    remove_column :cache_nodes, :ancestry, :string, index: true
  end
end
