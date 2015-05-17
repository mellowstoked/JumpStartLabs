class Tag < ActiveRecord::Base
  #telling rails about the realtionship
  has_many :taggings
  has_many :articles, through: :taggings


end
