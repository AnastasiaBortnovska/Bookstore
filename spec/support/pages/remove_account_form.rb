# frozen_string_literal: true

class RemoveAccountForm < SitePrism::Section
  element :button_remove, 'input[type="submit"]'
  element :checkbox, '.form-group.checkbox.general-settings-checkbox'
  element :checkbox_text, 'span', text: I18n.t('devise.registrations.partials.delete_form.checkbox_remove_account')

  def remove_account
    checkbox.click
    button_remove.click
  end
end
