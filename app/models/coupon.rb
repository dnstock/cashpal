class Coupon < ActiveRecord::Base
  belongs_to :affiliate

  acts_as_taggable_on :tags
  named_scope :is_active, :conditions => {:is_active => true}
  named_scope :find_active, :conditions => {:is_active => true}
  named_scope :find_newest_first, :conditions => {:is_active => true}, :order => "created_at DESC"
  named_scope :find_alphabetically, :conditions => {:is_active => true}, :order => "name"

  # make individual pages for each coupon, better SEO
  has_friendly_id :title, :use_slug => true, :strip_diacritics => true

  validates_presence_of :title
  validates_presence_of :coupon_code
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :link_redirect
  validates_presence_of :link_destination
  validates_uniqueness_of :title, :case_sensitive => false, :message => 'is already in use, choose something unique.'
  validates_uniqueness_of :coupon_code, :case_sensitive => false, :message => 'is already in use, choose something unique.'

  def affiliate_name
    affiliate && affiliate.name
  end

  def before_create
  end

end
