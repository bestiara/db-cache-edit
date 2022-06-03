class AddParentIdToDatabaseNode < ActiveRecord::Migration[7.0]
  def change
    add_column :database_nodes, :parent_id, :integer
    add_index :database_nodes, :parent_id
  end
end
