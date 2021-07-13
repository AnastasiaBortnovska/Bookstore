# frozen_string_literal: true

RSpec.describe Cart do
  let(:cart_page) { described_class.new }

  describe 'when order exists' do
    let!(:order) { create(:order, :with_iteam).decorate }

    let(:book) { order.order_books.last.book }

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
      cart_page.load
    end

    context 'when all elements are present' do
      it { expect(cart_page).to be_all_there }
      it { expect(cart_page).to have_iteam_info(text: order.subtotal_price) }
      it { expect(cart_page).to have_iteam_info(text: order.discount_price) }
      it { expect(cart_page).to have_iteam_info(text: order.total_price) }

      it { expect(cart_page.order_iteam).to have_link_book_title(text: book.title) }
      it { expect(cart_page.order_iteam).to have_book_price(text: book.price) }
      it { expect(cart_page.order_iteam).to have_delete_item_button }
      it { expect(cart_page.order_iteam).to have_image }
    end

    context 'when click on delete button' do
      it 'delete iteam' do
        cart_page.order_iteam.delete_item_button.click
        expect(cart_page).to have_flash_success(text: I18n.t('message.success.order_book.delete'))
      end
    end

    context 'when click on book title' do
      let(:book_view) { BookPage.new }

      it 'shows book view' do
        cart_page.order_iteam.link_book_title(text: book.title).click
        expect(book_view).to be_displayed
      end
    end

    context 'when sets valid coupon' do
      let(:coupon) { create(:coupon) }

      it 'shows flash success' do
        cart_page.coupon_form.fill_in(coupon.code)
        expect(cart_page).to have_flash_success(text: I18n.t('message.success.coupon.used'))
      end
    end

    context 'when sets invalid coupon' do
      let(:coupon) { attributes_for(:coupon, active: false) }

      it 'shows flash failure' do
        cart_page.coupon_form.fill_in(coupon[:code])
        expect(cart_page).to have_flash_failure(text: I18n.t('message.error.coupon.used'))
      end
    end
  end

  describe 'when order does not exist' do
    it 'shows message' do
      cart_page.load
      expect(cart_page).to have_empty_cart
    end
  end
end
