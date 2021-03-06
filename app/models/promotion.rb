# frozen_string_literal: true

class Promotion < ApplicationRecord
  validates :coupon_code, :valid_date, :minimum_amount, :discount_percent, presence: true
  validates_uniqueness_of :coupon_code
  validates :minimum_amount, numericality: { greater_than_or_equal_to: 1 }
  validates :discount_percent, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if valid_date < Date.today
  end

  def self.sort_by_params(promotion_option)
    if promotion_option == 'valid_date_asc'
      order('valid_date ASC')
    elsif promotion_option == 'valid_date_desc'
      order('valid_date DESC')
    elsif promotion_option == 'discount_percent_asc'
      order(:discount_percent)
    elsif promotion_option == 'discount_percent_desc'
      order(:discount_percent).reverse  
    else
      all
    end  
  end 

  def self.filter_by_params(filter_option)
    if filter_option == 'active_coupon'
      where(['valid_date >= ?', DateTime.now])
    elsif filter_option == 'expired_coupon'
      where(['valid_date < ?', DateTime.now])
    else
      all
    end
  end
end
