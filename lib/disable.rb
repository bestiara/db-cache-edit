module Disable
  def disable_deep!
    transaction do
      disable!
      children.each(&:disable_deep!)
    end
  end

  def disable!
    update_attribute(:state, 'disabled')
  end

  def disabled?
    state == 'disabled'
  end
end
