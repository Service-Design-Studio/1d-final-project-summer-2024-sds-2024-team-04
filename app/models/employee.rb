class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :contact_number, :address, :pincode, :city, :state, :date_of_birth, :date_of_hiring, :role, presence: true
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :contact_number, format: { with: /\A\d{10}\z/, message: "should be 10 digits" }
  validate :birth_date_before_hiring_date

  # Custom validation to ensure date of birth is before date of hiring
  def birth_date_before_hiring_date
    if date_of_birth.present? && date_of_hiring.present? && date_of_birth >= date_of_hiring
      errors.add(:date_of_birth, "must be before date of hiring")
    end
  end

  # Method to calculate age
  def age
    return nil unless date_of_birth.present?
    
    current_date = Date.today
    age = current_date.year - date_of_birth.year - ((current_date.month > date_of_birth.month || (current_date.month == date_of_birth.month && current_date.day >= date_of_birth.day)) ? 0 : 1)
    age
  end

  # Method to return the full name of the employee
  def full_name
    "#{first_name} #{last_name}".strip
  end

  # Specify the attributes available for ransack searching
  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "contact_number", "date_of_birth", "date_of_hiring", "email", "first_name", "last_name", "pincode", "state", "role"]
  end
end