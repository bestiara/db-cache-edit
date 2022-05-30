module Arrangeable
  def arrange_serializable(node_class)
    raise StandardError.new(
      'Класс не имеет реализации метода "arrange_serializable"'
    ) unless node_class.respond_to? :arrange_serializable

    node_class.arrange_serializable do |parent, children|
      {
        children: children,
        id: parent.id,
        value: parent.value,
        parent_id: parent.parent_id
      }
    end
  end
end
