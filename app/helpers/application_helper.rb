# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # used for creating tag cloud
  include TagsHelper

  # explicitly defining this function here for the sake of older Rails versions
  # this function is included in newer Rails versions
  unless respond_to?(:grouped_options_for_select)
    def grouped_options_for_select(grouped_options, selected_key = nil, prompt = nil)
      body = ''
      body << content_tag(:option, prompt, :value => "") if prompt
      grouped_options = grouped_options.sort if grouped_options.is_a?(Hash)
      grouped_options.each do |group|
        body << content_tag(:optgroup, options_for_select(group[1], selected_key), :label => group[0])
      end
      body
    end
  end

  # uses the grouped_options_for_select function for 'choices'
  # there was no way to use the 'select' helper method with optgroups
  # and the 'select_tag' method isn't meant to be used in a form_for (just form_tag)
  def select_with_grouped_options(object, method, choices, selected_key = nil, prompt = nil)
    name = object.class.name.downcase
    html = "<select id=\"#{name}_#{method}\" name=\"#{name}[#{method}]\">"
    html += grouped_options_for_select(choices, selected_key, prompt)
    html += "</select>"
  end

end
