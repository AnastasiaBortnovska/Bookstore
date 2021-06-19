class BookReviewForm < SitePrism::Section
    elements :score, 'input[type="radio"]'
    element :score_4, 'input[id="review_form_score_4"]'
    element :title, 'input[id="title"]'
    element :body, 'textarea[id="review"]'
    element :button_post, 'input[type="submit"]'

    def fill_in!(params)
        score_4.click
        title.set(params[:title])
        body.set(params[:body])
        button_post.click
    end
end
