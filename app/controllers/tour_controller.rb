class TourController < ApplicationController

  add_breadcrumb 'Tour', :tour_path
  layout 'web'

#  def tour
#    @tour_pages = { 'what'  => 'How It Helps',
#                    'how'   => 'How It Works',
#                    'video' => 'Watch a Video',
#                    'get'   => 'Join CashAddOn',
#                  }
#    params[:page] ||= 'what'  # default index page
#    add_breadcrumb 'Tour', web_url(:tour)
#    add_breadcrumb @tour_pages[params[:page].downcase]
#  end

  def what
    add_breadcrumb 'How It Helps'
    @what = {:id => 'on'}
  end

  def how
    add_breadcrumb 'How It Works'
    @how = {:id => 'on'}
  end

  def features
    add_breadcrumb 'Cool Features'
    @features = {:id => 'on'}
  end

  def screenshots
    add_breadcrumb 'Screenshots'
    @screenshots = {:id => 'on'}
  end

end
