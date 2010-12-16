#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 5-July-2009
# COMMENTS:
#   Loads 4 deals and 4 coupons for testing purposes.
# IMPORTANT:
#   Rolling back this migration with delete ALL deals & coupons from db
#-----------------------------------------------------------------------------
class LoadTestData < ActiveRecord::Migration
  def self.up
    Deal.delete_all
    Coupon.delete_all
    # active affid = 4,5,7,10,11,15,17,80,84,634,637,672,674,675,678
    Deal.create(
      :tag_list => 'Summer, Kids, Sneakers',
      :affiliate_id => 4,
      :product_image => '',
      :title => 'Summer Sale on Kids Sneakers',
      :price => nil,
      :msrp => nil,
      :rebate => nil,
      :free_shipping => false,
      :description => '',
      :link_redirect => 'http://localhost/test-deal-1',
      :start_date => '2009-06-30',
      :end_date => '2009-07-24'
    )
    Deal.create(
      :tag_list => 'Magelin, GPS, Electronics',
      :affiliate_id => 5,
      :product_image => '',
      :title => 'Magelin 7" touch screen GPS',
      :price => 159.99,
      :msrp => nil,
      :rebate => 25.00,
      :free_shipping => true,
      :description => 'Buy a magelin GPS through July 24 and receive a $25 instant rebate.',
      :link_redirect => 'http://localhost/test-deal-2',
      :start_date => '2009-06-30',
      :end_date => '2009-07-24'
    )
    Deal.create(
      :tag_list => 'Beach, Sandals, Footware',
      :affiliate_id => 7,
      :product_image => 'sandal.gif',
      :title => 'Men\'s Beach Trekker Sandals',
      :price => 9.99,
      :msrp => 39.99,
      :rebate => 0,
      :free_shipping => true,
      :description => '',
      :link_redirect => 'http://localhost/test-deal-3',
      :start_date => '2009-06-30',
      :end_date => '2009-07-24'
    )
    Deal.create(
      :tag_list => 'Lamp, Office, Free Shipping',
      :affiliate_id => 10,
      :product_image => 'robot_lamp.jpg',
      :title => 'Robot Desk Lamp | Free Shipping — Kotula\'s',
      :price => 12.99,
      :msrp => nil,
      :rebate => nil,
      :free_shipping => false,
      :description => '',
      :link_redirect => 'http://localhost/test-deal-4',
      :start_date => '2009-06-30',
      :end_date => '2009-07-24'
    )
    Coupon.create(
      :tag_list => 'Basketball, Sneakers, Mensware',
      :affiliate_id => 11,
      :title => '80% new mens basketball sneakers',
      :coupon_code => 'F2JF39G3SW',
      :description => 'New Customers: $10 off $200 All Stores',
      :link_redirect => 'http://localhost/test-coupon-1',
      :is_stackable => 1,
      :start_date => '2009-06-30',
      :end_date => '2009-07-24'
    )
    Coupon.create(
      :tag_list => 'Sale, Discount',
      :affiliate_id => 15,
      :title => 'Take 10% Off your entire purchase',
      :coupon_code => 'F3SW5EWWE',
      :description => '',
      :link_redirect => 'http://localhost/test-coupon-2',
      :is_stackable => 1,
      :start_date => '2009-07-01',
      :end_date => '2009-08-11'
    )
    Coupon.create(
      :tag_list => 'Houseware, Discount',
      :affiliate_id => 637,
      :title => '$20 off $200 on all houseware',
      :coupon_code => 'AWE423ART2',
      :description => 'Get a 10% discount when you spend $200 on household items.',
      :link_redirect => 'http://localhost/test-coupon-3',
      :is_stackable => 0,
      :start_date => '2009-07-03',
      :end_date => '2009-09-20'
    )
    Coupon.create(
      :tag_list => 'Redeemable, Great Deal',
      :affiliate_id => 672,
      :title => 'Redeemable 10% off at checkout',
      :coupon_code => 'ZBV845WESD',
      :description => '',
      :link_redirect => 'http://localhost/test-coupon-4',
      :is_stackable => 0,
      :start_date => '2009-07-03',
      :end_date => '2009-10-28'
    )
  end

  def self.down
    Deal.delete_all
    Coupon.delete_all
  end
end
