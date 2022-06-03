class AddStateToCacheNodes < ActiveRecord::Migration[7.0]
  def change
    add_column :cache_nodes, :state, :string
  end
end
