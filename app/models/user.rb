require 'area'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validate :valid_us_zipcode, on: :update

  def valid_us_zipcode
    begin
      errors.add(:zipcode, "must be a valid US zipcode") unless zipcode.to_region
    rescue ArgumentError
      errors.add(:zipcode, "must be a valid US zipcode")
    end
  end
end
