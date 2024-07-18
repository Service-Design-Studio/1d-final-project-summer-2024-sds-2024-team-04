class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :password, :employee_id
end
