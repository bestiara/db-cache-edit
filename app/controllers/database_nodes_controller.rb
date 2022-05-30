class DatabaseNodesController < ApplicationController
  include Arrangeable

  def index
    @db_nodes = arrange_serializable(DatabaseNode)
  end
end
