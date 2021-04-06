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
end
