class CantUpdateDisabledValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :state, "Нельзя изменять удаленные элементы" if record.disabled? && record.value_changed?
  end
end
