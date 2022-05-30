class CacheNodesController < ApplicationController
  include Arrangeable

  def index
    @cache_node = arrange_serializable(CacheNode)
  end
end
