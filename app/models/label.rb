class Label < ActiveRecord::Base
  has_many :labelings
  has_many :topics, through: :labelings, source: :labelable, source_type: :Topic 
  has_many :posts, through: :labelings, source: :labelable, source_type: :Post
end
