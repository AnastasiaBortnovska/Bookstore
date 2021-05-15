# frozen_string_literal: true

RSpec.describe AuthorDecorator do
  subject(:author) { build(:author).decorate }

  describe '#full_name' do
    it { expect(author.full_name).to eq("#{author.first_name} #{author.last_name}") }
  end
end
