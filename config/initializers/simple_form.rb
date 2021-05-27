SimpleForm.setup do |config|
  config.wrappers :default, class: 'input form-group mb-30',
    hint_class: :field_with_hint, error_class: 'has-error', valid_class: :field_without_errors do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :full_error, wrap_with: { tag: :span, class: 'help-block' }
  end

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.button_class = 'btn btn-default mb-20'
  config.error_notification_tag = :div
  config.error_notification_class = 'error_notification'
  config.browser_validations = false
  config.boolean_label_class = 'checkbox'
  config.label_text = lambda { |label, required, explicit_label| "#{label}" }
  config.label_class = 'control-label input-label'
  config.required_by_default = true
  config.input_class = 'form-control'
end
