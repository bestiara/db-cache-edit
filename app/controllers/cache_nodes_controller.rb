class CacheNodesController < ApplicationController
  before_action :set_cache_node, only: [:update, :destroy]

  def index
    @cache_nodes = get_cache_modes_list
  end

  def create
    @cache_node = begin
                    CacheNode.create(create_cache_node_params)
                  rescue ActiveRecord::RecordNotUnique
                    CacheNode.find_or_initialize_by(create_cache_node_params)
                  end

    if @cache_node.save
      @cache_nodes = get_cache_modes_list
      render :index
    else
      render json: { errors: @cache_node.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @cache_node.update(update_cache_node_params)
      render json: { status: :ok }
    else
      render json: { errors: @cache_node.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @cache_node.disable_deep! unless @cache_node.disabled?
    @cache_nodes = get_cache_modes_list
    render :index
  end

  private

  def create_cache_node_params
    params.permit(:id, :value, :parent_id, :origin_id)
  end

  def update_cache_node_params
    params.permit(:value)
  end

  def set_cache_node
    @cache_node = CacheNode.find(params[:id])
  end

  def get_cache_modes_list
    CacheNode.arrange_serializable do |parent, children|
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
end
