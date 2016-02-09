module ApplicationHelper
  #method takes an array of errors and a block as arguments
  def form_group_tag(errors, &block)
    css_class = 'form_group'
    css_class << ' has-error' if errors.any?
    #content tag helper method builds HTML and CSS to display the form element and associated errors
    content_tag :div, capture(&block), class: css_class
  end
end
