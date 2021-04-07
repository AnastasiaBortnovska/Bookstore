# frozen_string_literal: true

class Home < SitePrism::Page
  set_url '/'

  element :nav_bar, 'div.navbar-header'
  element :slider, 'div#slider'
  element :btn_prev, 'a.left'
  element :btn_next, 'a.right'
  element :best_sellers, 'div#best_sellers'
  elements :item_best_sellers, 'div#best_sellers div.col-sm-6'
  element :footer, 'footer.navbar-inverse'

  element :title, 'a', text: I18n.t('header.title')
  element :btn_home, 'a', text: I18n.t('header.home')
  element :btn_shop, 'a', text: I18n.t('header.shop')
  element :footer_orders, 'a', text: I18n.t('footer.orders')
  element :footer_email, 'p', text: I18n.t('footer.email')
  element :greeting, 'h2.h1', text: I18n.t('home_page.greeting')
  element :btn_start, 'button', text: I18n.t('home_page.btn_start')
  element :text_best_sellers, 'h3', text: I18n.t('home_page.best')

  element :header, 'header'
end
