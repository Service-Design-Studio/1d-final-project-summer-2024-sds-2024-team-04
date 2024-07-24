class Employee < ApplicationRecord
  belongs_to :role
  has_one :user
  has_many :case
end
