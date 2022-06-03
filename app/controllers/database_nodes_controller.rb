class DatabaseNodesController < ApplicationController
  def index
    @db_nodes = DatabaseNode.arrange_serializable do |parent, children|
      {
        children: children,
        id: parent.id,
        text: parent.value,
        state: {
          opened: true,
          disabled: parent.disabled?
        },
        data: {
          parent_id: parent.parent_id
        }
      }
    end
  end

  def apply
    syncher = CacheDbSyncher.new

    if syncher.call
      render json: {}, status: :ok
    else
      render json: { errors: syncher.errors }, status: :unprocessable_entity
    end
  end


end
