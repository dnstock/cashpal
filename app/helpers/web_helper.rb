module WebHelper
  # used for grouped_options_for_select method
  include ActionView::Helpers::FormOptionsHelper

  def flash_notice
    "<div id=\"notice\">#{flash[:notice]}</div>" unless flash[:notice].blank?
  end

  def spacer(dimentions)
    # USAGE: spacer('8x29') -or- spacer(3) => '3x3'
    dimentions = dimentions.to_s+'x'+dimentions.to_s if dimentions.is_a?(Integer)
    image_tag('spacer.gif', :size => dimentions, :alt => '')
  end

  def homepage?
    current_page?(root_url)
  end

  def get_page_title
    default_page_title = 'CashAddOn - the Firefox addon that saves you money and gets you cash back'
    if homepage?
      default_page_title
    elsif @page_title
      @page_title
    else
      breadcrumbs(:is_page_title => true, :separator => '&nbsp;:&nbsp;') + ' | ' + default_page_title
    end
  end

  def get_topnav
    topnav  = homepage? ? '<div id="header-hp">' : '<div id="header">'
    topnav += render :partial => 'web/topnav'
    topnav += link_to 'Download Once. Save Forever.', root_url, :id => 'logo'
    return topnav + '</div>'
  end

  def get_cao_link
    link_to(image_tag('but-get-cashaddon-now.png',
                      :size => '174x41',
                      :alt => 'Get it now, it\'s free!'), download_url, :id=>'get-cashaddon')
#            "/addon/cashaddonFF3.xpi",
#            { :id => 'get-cashaddon', :onclick=>"return install(event,'CashAddOn.com','http://cashaddon.com/images/status-plus.png','');" } )
  end

  def render_userbox
    if (current_user)
      render :partial => 'web/account_nav'
    else
      @login = UserSession.new
      linkstr = '<div id="loginbox0"><a href="#" onclick="showlogin(1)">Sign in to your account</a></div><span id="loginbox00" style="display:none"></span>'
      linkstr += render :partial => 'web/loginbox'
    end
  end

  def get_user_cashback_summary
    str = String.new
    str << '<span title="Available Cash Back" class="cashback-quickview">' + number_to_currency(user_cashback_summary.available || 0) + '</span> '
    str << '<span title="Pending Cash Back" class="cashback-quickview">(' + number_to_currency(user_cashback_summary.pending || 0) + ')</span>'
  end

  def hello_user
    '<a href="#" onclick="showlogin(1)">Hello, Guest</a>'
  end

  def homepage_news
    # mock blog posts
    @items = Array.new
    @items << {:date=>'11.19.2008', :name=>'Open Web Awards - Round 1', :link=>'blog1'}
    @items << {:date=>'11.17.2008', :name=>'Sharing bigger than Facebook', :link=>'blog2'}
    @items << {:date=>'11.13.2008', :name=>'Digital Hub Conference', :link=>'blog3'}
    # aggregate news/blog posts
    @news = Array.new
    @items.each do |item|
      @news << "<span class='grey'>&bull;</span> <a href=\"#{item[:link]}\">#{item[:date]}: #{item[:name]}</a>"
    end
    #return @news.join('<br />')
    return "No news or updates to report."
  end

  def homepage_counter
    downloads = 44949
    counter = Array.new
    number_with_delimiter(downloads).split(//).each do |x|
      x = 'comma' if x == ','
      counter << image_tag("green_#{x}.gif", :alt => x)
    end
    counter << ' '
    counter << link_to(image_tag('secret-to-savings.gif',
                       :size => '635x38',
                       :alt => 'Are you among the ranks of those who know the secret to savings?'),
                       web_url(:download),
                       :id => 'savings' )
    counter.to_s
  end

  def policies_footer_links
    puts link_to('&laquo; Go to home page', root_url)
    puts link_to('Download CashAddOn &raquo;', web_url(:download))
  end

  def cao_download_link
    link_to web_url(:download), :id => 'download-cashaddon' do
      image_tag 'get-cashaddon-now.png', :size => '310x93', :alt => 'Get CashAddOn For Free'
    end
  end
  
  def homepage_footer_style
    homepage? ? {:style => 'border:0'} : {}
  end

  def build_select_for_search_form
    select = "<select name='section' id='section'>"
    select << options_for_select(%w{ Stores Deals Coupons }, params[:controller].capitalize)
    select + '</select>'
  end

  def help_nav
    #format: page, link name, link url
    menu = [
      ['Common Questions (FAQs)', web_url(:faq)],
#      ['CashBack Glossary', web_url(:glossary)],
      ['Bugs &amp; Feedback', 'http://uservoice.com/cashaddon'],
      ['Get In Touch', web_url(:contact)],
      ['Terms &amp; Conditions', web_url(:terms)],
      ['Privacy Policy', web_url(:privacy)],
      ['Download CashAddOn', download_url],
#      ['Our Mozilla Add-ons page', 'http://addons.mozilla.org/cashaddon'],
    ]
    str_menu = String.new
    menu.each do |tab|
      #str_menu += controller.action_name == tab[0] ? '<li><span>'+tab[1]+'</span></li>' : '<li><a href="'+tab[2]+'">'+tab[1]+'</a></li>'
      str_menu += current_page?(tab[1]) ? '<li><span>'+tab[0]+'</span></li>' : '<li><a href="'+tab[1]+'">'+tab[0]+'</a></li>'
    end
    return '<div id="help-nav"><p>Help &amp; Support</p><ul>'+str_menu+'</ul></div>'
  end

##########################################################
#  ARCHIVE OF DEPRICATED METHODS
#  =======================================================
#
#  @@weblist = {'For Organizations'  => :organizations,
#              'Referrals'          => :referrals,
#              'Press'              => 'mailto:press@cashaddon.com',
#              'Jobs'               => 'mailto:jobs@cashaddon.com',
#              'Privacy Policy'     => :privacy,
#              'Terms &amp; Conditions'       => :terms,
#              'About Us'           => :about,
#              'Write Us'         => :contact,
#              'Our Blog'           => :blog,
#              'Get It Now!'        => :download,
#              'Top of Page'        => '#top',
#              'Cash Back Shops'    => :cashback,
#              'FAQ'                => :faq,
#              'Site Map'           => :sitemap
#             }
#
#  def homepage_learn_more_link
#    link_to(image_tag('hp-secret-to-savings.gif',
#                      :size => '635x38',
#                      :alt => 'Are you among the ranks of those who know the secret to savings?'),
#            web_url(:download),
#            { :id => 'savings' } )
#  end
#
#  # links on page: /layouts/index.haml
#  def nav_links(links, delimiter=' ')
#    linkstr = String.new
#    links.split(/, /).each do |link|
#      linkstr.empty? ? linkstr = '' : linkstr += delimiter
#      if(@@weblist[link] == :root)
#        linkstr += link_to(link, root_url)
#      elsif(@@weblist[link].is_a? Symbol)
#        linkstr += link_to(link, web_url(@@weblist[link]))
#      else
#        linkstr += link_to(link, @@weblist[link])
#      end
#    end
#    return linkstr
#  end
#
#  def breadcrumb(curr_page='', crumbs='')
#    if curr_page.empty? && @@weblist.has_value?(controller.action_name.to_sym)
#      curr_page = @@weblist.index(controller.action_name.to_sym)
#    elsif curr_page.empty?
#      curr_page = 'You Are Here'
#    end
#    # TOUR PAGES
#    if controller.action_name == 'tour' && !params[:page].nil?
#      crumbstr  = link_to curr_page, web_url(:tour), :class => 'crumb-link'
#      crumbstr += '<span id="crumb-title">' + @tour_pages[params[:page].downcase] + '</span>'
#    else
#      crumbstr = '<span id="crumb-title">' + curr_page + '</span>'
#    end
#    return link_to('Home', root_url, :id => 'crumb-hp') + crumbstr
#  end

#  def get_header
#    case controller.controller_name
#      when 'user_sessions', 'password_resets', 'account'
#        curr_page = 'account'
#        img_alt = 'My Account'
#        img_h = 96
#      else
#        curr_page = controller.action_name.to_sym
#        img_alt = @@weblist.has_value?(curr_page) ? @@weblist.index(curr_page) : curr_page.to_s.titleize
#        if curr_page == :tour
#          img_h = 96
#        else
#          img_h = 127
#        end
#    end
#    image_tag "hdr-#{curr_page}.png", :width => 950, :alt => img_alt #, :height => img_h
#  end

#  def get_footer
#    case controller.controller_name
#      when 'account'
#        image_tag 'page-btm.png', :width => 950, :height => 10
#      else
#        image_tag 'page-btm.gif', :width => 950, :height => 65
#    end
#  end

#  def store_alpha_search
#    @alpha = '<p id="alpha">'
#    %w{0-9 a b c d e f g h i j k l m n o p q r s t u v w x y z}.each do |a|
#      @alpha += "<a href=\"\##{a}\">#{a.upcase}</a>"
#    end
#    return @alpha + '</p>'
#  end

#  def install_cao_reminder
#    caostr = '<div id="cao-reminder">Grab your free copy of CASH<span>ADD</span>ON and <span>never</span> miss a cash-back opportunity! '
#    caostr += link_to 'Learn More', web_url(:tour)
#    return caostr + '</div>'
#  end

end
