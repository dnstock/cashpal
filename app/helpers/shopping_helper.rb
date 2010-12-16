module ShoppingHelper
  # used for parsing url for default logo filename
  require 'uri'

  def get_store_links(stores)
    store_links = Array.new
    stores.each do |s|
      cb = (not s.cashback_to_user.blank?) && s.cashback_to_user > 0 ? "<span>#{s.cashback_to_user}%</span>" : ''
      link = link_to(cb+s.name, shopping_url(s))
      store_links << "<li>#{link}</li>"
    end
    store_links.to_s
  end

  # max => max # of stores to return
  def get_popular_store_links(stores, max = 6)
    store_links = Array.new
    stores[0..max-1].each do |s|
      cb = (not s.cashback_to_user.blank?) && s.cashback_to_user > 0 ? " <span>(#{s.cashback_to_user}%)</span>" : ''
      link = link_to(image_tag(get_store_logo(s,true), :alt=>s.name) + "<br/>#{s.name}#{cb}", shopping_url(s))
      store_links << "<li>#{link}</li>"
    end
    store_links.to_s
  end

  def get_tag_cloud(tags, levels = nil)
    if tags.empty?
      "No tags"
    else
      cloud = Array.new
      levels ||= (1..5).map { |i| "level-#{i}" }
      tag_cloud(tags, levels) do |tag,level|
        link = link_to(tag.name, tag_url(tag.name.gsub(/\s/, '-')), :class => level)
        cloud << "#{link} &nbsp; "
      end
      cloud.to_s
    end
  end

  def get_tags(record)
    taglist = Array.new
    record.tags.each do |tag|
      taglist << link_to( tag.name, tag_url(tag.name.gsub(/\s/, '-')) )
    end
    taglist.join(', ')
  end

  def get_cashback_terms(store)
    return '' if store.cashback_terms.blank?
    terms = String.new
    store.cashback_terms.split('##').each do |term|
      terms << "<li>#{term}</li>" unless term.blank?
    end
    terms
  end

  def get_store_logo(store, small=false)
    small = small ? 'small/' : ''
    store_img_path = '/public/images/stores/' + small
    # primar option: filename stored in db
    if( file_exists?(store_img_path + store.logo_filename) )
      return "stores/#{small}#{store.logo_filename}"
    end
    # secondary options (in order): [root_url].gif | [root_url-ext].gif | same for jpg | same for png
    url = URI.parse(store.root_url)
    no_ext = (url.host || url.path).split('.')[-2,1]  # http://... then url.host, if just www.domain.com or domain.com then fn.path (url.host = nil)
    yes_ext = (url.host || url.path).split('.')[-2,2].join('.')
    fn = ["#{no_ext}.gif", "#{yes_ext}.gif", "#{no_ext}.jpg", "#{yes_ext}.jpg", "#{no_ext}.png", "#{yes_ext}.png"]
    fn.each { |file| return "stores/#{small}#{file}" if file_exists?(store_img_path + file) }
    return "stores/#{small}no-image.gif"
  end

  # for Deals
  def get_prices(deal)
    return if deal.price.blank?
    price = Array.new
    price << "<span class=\"msrp\">#{number_to_currency(deal.msrp)}</span>" unless deal.msrp.blank? || deal.msrp < 0.01
    price << (deal.price > 0.01 ? "<span class=\"price\">#{number_to_currency(deal.price)}</span>" : '<span class="price free">Free</span>')
    price << "<span class=\"cashback-price\">#{number_to_currency(deal.price-(deal.price*(deal.affiliate.cashback_to_user/100)))} after cash back savings</span>" if deal.price > 0.01
    price.join(' &nbsp;|&nbsp; ')
  end

  # for Deals
  def get_discounts(deal)
    discount = Array.new
    discount << "<span class=\"rebate\">#{number_to_currency(deal.rebate,:precision => 0)} rebate</span>" unless deal.rebate.blank? || deal.rebate < 0.01
    discount << '<span class="free-shipping">Free Shipping</span>' if deal.free_shipping
    discount << "<span class=\"end-date\">#{deal.end_date.strftime("Ends: %a, %B %d")}</span>"
    discount.join(' &nbsp;|&nbsp; ')
  end

  # for Coupons
  def get_meta(coupon)
    meta = Array.new
    meta << "<span class=\"end-date\">#{coupon.end_date.strftime("Ends: %a, %B %d")}</span>"
    meta << '<span class="stackable">Stackable Coupon</span>' if coupon.is_stackable
    meta.join(' &nbsp;|&nbsp; ')
  end

  def get_logo_with_cashback(record)
    r = Array.new
    r << image_tag( get_store_logo(record.affiliate,true) )
    r << number_to_percentage(record.affiliate.cashback_to_user,:precision=>1) + ' Cash Back'
    r.join('<br/>')
  end

end
