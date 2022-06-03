module Arrange
  # these methods arrange an entire subtree into nested hashes for easy navigation after database retrieval
  # the arrange method also works on a scoped class
  # the arrange method takes ActiveRecord find options

  # Get all nodes and sort them into an empty hash
  def arrange options = {}
    arrange_nodes where(options)
  end

  # Arrange array of nodes into a nested hash of the form
  # {node => children}, where children = {} if the node has no children
  # If a node's parent is not included, the node will be included as if it is a top level node
  def arrange_nodes(nodes)
    node_ids = Set.new(nodes.map(&:id))
    index = Hash.new { |h, k| h[k] = {} }

    nodes.each_with_object({}) do |node, arranged|
      children = index[node.id]
      index[node.parent_id][node] = children
      arranged[node] = children unless node_ids.include?(node.parent_id)
    end
  end

  # Arrangement to nested array for serialization
  # You can also supply your own serialization logic using blocks
  # also allows you to pass the order just as you can pass it to the arrange method
  def arrange_serializable options={}, nodes=nil, &block
    nodes = arrange(options) if nodes.nil?
    nodes.map do |parent, children|
      if block_given?
        yield parent, arrange_serializable(options, children, &block)
      else
        parent.serializable_hash.merge 'children' => arrange_serializable(options, children)
      end
    end
  end
end
