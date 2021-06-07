# frozen_string_literal: true

class Menu < SitePrism::Section
  element :item_menu, 'a'
  element :button_log_in, 'a', text: I18n.t('partials.header.log_in')
  element :button_sing_up, 'a', text: I18n.t('partials.header.sign_up')
end
