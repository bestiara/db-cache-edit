def create_node(children, parent = nil)
  children.each do |node|
    db_node = DatabaseNode.create(
      value: node['value'],
      parent: parent
    )

    create_node(node['children'], db_node) if node['children']
  end
end

DatabaseNode.destroy_all

path = File.join(File.dirname(__FILE__), "../config/nodes.json")
nodes = JSON.parse(File.read(path))
create_node(nodes)
