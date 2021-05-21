# frozen_string_literal: true

if Rails.application.config.seeds_enabled
  20.times do
    FactoryBot.create :book, :with_authors
  end
end
