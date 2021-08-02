# frozen_string_literal: true

RSpec.describe OrderMailer, type: :mailer do
  describe '#completed_order' do
    let(:user) { create(:user) }
    let(:order) { create(:order, user: user) }
    let(:mail) { described_class.completed_order(order) }

    it 'renders headers' do
      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq I18n.t('mailer.order.subject')
    end
  end
end
