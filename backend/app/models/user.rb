class User < ApplicationRecord
  belongs_to :employee

  has_many :human_audited_score
end
