class AddParentIdToCacheNode < ActiveRecord::Migration[7.0]
  def change
    add_column :cache_nodes, :parent_id, :integer
    add_index :cache_nodes, :parent_id
  end
end
