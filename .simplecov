# frozen_string_literal: true

SimpleCov.start 'rails' do
  add_filter '/mailers/'
  add_filter '/jobs/'
  minimum_coverage 95
end
