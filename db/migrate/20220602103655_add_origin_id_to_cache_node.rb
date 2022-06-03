class AddOriginIdToCacheNode < ActiveRecord::Migration[7.0]
  def change
    add_column :cache_nodes, :origin_id, :integer
    add_index :cache_nodes, :origin_id
  end
end
