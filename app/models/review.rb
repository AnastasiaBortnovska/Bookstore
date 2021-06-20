class Review < ApplicationRecord
    STATE = {
        :approved => 'approved',
        :rejected => 'rejected',
        :unprocessed => 'unprocessed'
    }

    belongs_to :book
    belongs_to :user

    validates :title, :body, presence: true

    scope :unprocessed, -> { where state: STATE[:unprocessed] }
    scope :approved, -> { where state: STATE[:approved] }
    scope :rejected, -> { where state: STATE[:rejected] }
end
