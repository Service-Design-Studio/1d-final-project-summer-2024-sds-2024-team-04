class EmployeeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :contact_no, :role_id

  has_one :user
end
