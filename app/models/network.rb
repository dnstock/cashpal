class Network < ActiveRecord::Base
  has_many :affiliates

  validates_presence_of :name
  validates_presence_of :url
  validates_uniqueness_of :name, :case_sensitive => false, :message => 'is already in use, choose something unique.'
  validates_uniqueness_of :url, :case_sensitive => false, :message => 'is already in use, choose something unique.'

end
