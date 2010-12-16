module Breadcrumbs

  module InstanceMethods

    protected

    # Append a breadcrumb to the end of the trail
    def add_breadcrumb(name, url =  nil)
      @breadcrumbs ||= []
      url = send(url) if url.is_a?(Symbol)
      name = send(name).to_s.titleize if name.is_a?(Symbol)
      @breadcrumbs << [name, url]
    end

  end

  module ClassMethods

    # Append a breadcrumb to the end of the trail by deferring evaluation 
    # until the filter processing.
    def add_breadcrumb(name, url = nil, options = {})
      before_filter(options) do |controller|
        controller.send(:add_breadcrumb, name, url)
      end
    end

  end

  module HelperMethods

    # Returns HTML markup for the breadcrumbs
    def breadcrumbs(*args)
      default_options = {:separator => '', :tag => nil, :html => nil, :is_page_title => false}
      options = default_options.merge(args.extract_options!)
      crumbs = Array.new
      crumbs = @breadcrumbs.dup                # create temp array to manipulate
      crumbs.shift if options[:is_page_title]  # don't display 'Home' in page title
      crumb_count, last_crumb = 0, crumbs.length
      crumbs.map do |name, url|
        if( options[:is_page_title] )
          name
        elsif( (crumb_count+=1) == 1)
          link_to( name, url, { :id => 'first-crumb' } )
        elsif(crumb_count == last_crumb)
          content_tag( :span, name, { :id => 'last-crumb' } )
        else
          link_to( name, url, { :class => 'crumb-link' } )
        end
        #crumb = link_to_unless_current(name, url)
        #options[:tag] && content_tag(options[:tag], crumb) || crumb
      end.join("#{options[:separator]}")
    end

  end

end

class ActionController::Base
  include Breadcrumbs::InstanceMethods
  helper_method :add_breadcrumb
end

ActionController::Base.extend(Breadcrumbs::ClassMethods)
ActionView::Base.send(:include, Breadcrumbs::HelperMethods)