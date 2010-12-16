class Deal < ActiveRecord::Base
  belongs_to :affiliate

  acts_as_taggable_on :tags
  named_scope :is_active, :conditions => {:is_active => true}
  named_scope :find_active, :conditions => {:is_active => true}
  named_scope :find_newest_first, :conditions => {:is_active => true}, :order => "created_at DESC"
  named_scope :find_alphabetically, :conditions => {:is_active => true}, :order => "name"

  # make individual pages for each deal, better SEO
  has_friendly_id :title, :use_slug => true, :strip_diacritics => true

  validates_presence_of :title
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :link_redirect
  validates_presence_of :link_destination
  validates_uniqueness_of :title, :case_sensitive => false, :message => 'is already in use, choose something unique.'
  validates_uniqueness_of :link_redirect, :case_sensitive => false, :message => 'is already in use, choose something unique.'
  validates_uniqueness_of :link_destination, :case_sensitive => false, :message => 'is already in use, choose something unique.'
  validates_numericality_of :price, :allow_nil => true, :allow_blank => true
  validates_numericality_of :rebate, :allow_nil => true, :allow_blank => true
  validates_numericality_of :msrp, :allow_nil => true, :allow_blank => true

  def affiliate_name
    affiliate && affiliate.name
  end

end
