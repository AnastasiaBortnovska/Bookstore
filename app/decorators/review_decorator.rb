class ReviewDecorator < Draper::Decorator
    delegate_all

    def slash_date_format
        created_at.strftime('%m/%d/%Y')
    end
end
