import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"

Rails.start()
Turbolinks.start()

import $ from 'jquery';

window.$ = $;
window.jQuery = $;

import 'bootstrap-sass/assets/javascripts/bootstrap';
import '../js/books'
import '../js/user_settings'
