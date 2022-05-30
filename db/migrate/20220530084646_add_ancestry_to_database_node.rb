class AddAncestryToDatabaseNode < ActiveRecord::Migration[7.0]
  def change
    add_column :database_nodes, :ancestry, :string
    add_index :database_nodes, :ancestry
  end
end
