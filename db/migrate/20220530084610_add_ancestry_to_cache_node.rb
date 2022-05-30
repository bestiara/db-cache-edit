class AddAncestryToCacheNode < ActiveRecord::Migration[7.0]
  def change
    add_column :cache_nodes, :ancestry, :string
    add_index :cache_nodes, :ancestry
  end
end
