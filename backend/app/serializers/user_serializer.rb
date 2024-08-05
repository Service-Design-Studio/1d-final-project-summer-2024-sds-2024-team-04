class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :password, :employee_id

  has_many :human_audited_score
  
end
