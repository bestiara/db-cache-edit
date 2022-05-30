class CreateDatabaseNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :database_nodes do |t|
      t.string :value

      t.timestamps
    end
  end
end
