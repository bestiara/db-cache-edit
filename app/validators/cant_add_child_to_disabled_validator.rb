class CantAddChildToDisabledValidator < ActiveModel::Validator
  def validate(record)
    parent = record.parent
    if parent&.disabled? && record.origin.nil?
      record.errors.add :state, "Нельзя добавить потомка удаленному элементу"
    end
  end
end
