# frozen_string_literal: true

class Menu < SitePrism::Section
  Category.all.each_with_index do |category_name, index|
    element "category#{index}".to_sym, 'a', text: category_name
  end
  element :my_account, 'a', text: I18n.t('partials.header.my_account')
end
