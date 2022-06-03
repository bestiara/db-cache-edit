class AddStateToDatabaseNodes < ActiveRecord::Migration[7.0]
  def change
    add_column :database_nodes, :state, :string
  end
end
