require 'area'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :user_tags
  has_many :tags, through: :user_tags

  has_many :user_bills
  has_many :bills, through: :user_bills
  
  accepts_nested_attributes_for :user_tags, :reject_if => lambda { |a| a[:tag_id].blank? }, allow_destroy: true

  validate :valid_us_zipcode, on: :update

  def valid_us_zipcode
    errors.add(:zipcode, "must be a valid US zipcode") unless zipcode.to_region
  rescue ArgumentError
    errors.add(:zipcode, "must be a valid US zipcode")
  end

  def legislators_by_zipcode
    lq = LegislatorQuery.new(Legislator.all, zipcode)
    lq.search
  end
end
