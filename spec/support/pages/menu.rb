# frozen_string_literal: true

class Menu < SitePrism::Section
  element :mobile_dev, 'a', text: I18n.t('partials.header.mobile_dev')
  element :photo, 'a', text: I18n.t('partials.header.photo')
  element :desing, 'a', text: I18n.t('partials.header.desing')
  element :my_account, 'a', text: I18n.t('partials.header.my_account')
end
