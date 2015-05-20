class Tag < ActiveRecord::Base
  #telling rails about the realtionship
  has_many :taggings
  #an article has a list of tags through the relationship of taggings

  has_many :articles, through: :taggings


end
