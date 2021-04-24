# frozen_string_literal: true

class Menu < SitePrism::Section
  element :item_menu, 'a'
  element :my_account, 'a', text: I18n.t('partials.header.my_account')
end
