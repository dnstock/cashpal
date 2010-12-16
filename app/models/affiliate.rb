class Affiliate < ActiveRecord::Base
  belongs_to :network
  has_many :deals
  has_many :coupons

  has_friendly_id :name, :use_slug => true, :strip_diacritics => true

  acts_as_taggable_on :tags
  named_scope :is_active, :conditions => {:is_active => true}
  named_scope :find_active, :conditions => {:is_active => true}
  named_scope :find_stores, :conditions => {:is_active => true}, :order => "name"
  named_scope :find_popular_stores, :conditions => {:is_active => true, :is_popular => true}

  validates_presence_of :name
  validates_presence_of :root_url
  validates_presence_of :commission_from_affiliate
  validates_presence_of :cashback_to_user
  validates_presence_of :link_redirect

  validates_uniqueness_of :name, :case_sensitive => false, :message => 'is already in use, choose something unique.'
  validates_uniqueness_of :root_url, :case_sensitive => false, :message => 'is already in use, choose something unique.'

  validates_numericality_of :commission_from_affiliate
  validates_numericality_of :cashback_to_user

  def network_name
    network && network.name
  end

end
