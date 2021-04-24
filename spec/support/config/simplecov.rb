# frozen_string_literal: true

SimpleCov.start 'rails' do
  add_filter 'spec'
  add_filter '/mailers/'
  add_filter '/jobs/'
  add_filter '/helpers/' # helpers are empty, but SimpleCov takes them into account
  minimum_coverage 95
end
