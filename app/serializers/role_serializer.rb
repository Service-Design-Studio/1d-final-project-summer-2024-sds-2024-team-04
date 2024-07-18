class RoleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description

  has_many :employee
end
