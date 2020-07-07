class Agent < ApplicationRecord
  has_many :subagents
  belongs_to :masteragent
end
