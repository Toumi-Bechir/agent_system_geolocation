class Subagent < ApplicationRecord
  has_many :shops
  belongs_to :agent
end
