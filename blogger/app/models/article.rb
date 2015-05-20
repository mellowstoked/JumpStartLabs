class Article < ActiveRecord::Base
  has_many :comments
  #telling rails about the relationship
  has_many :taggings
  #taggings is the connection between Articles and Tags
  has_many :tags, through: :taggings
  has_many :attachments
  #part of the paperclip library
  has_attached_file :image, styles: {medium: "700x300>", thumb: "300x300>"}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  #look back at /articles/_form.html.erb
  #need a method called tag_list to display related tags
  def tag_list
    #converting all tag objects to an array of tag names
    self.tags.collect do |tag|
      tag.name
    end.join(", ") #join the array of tag names with a comma
  end

  def tag_list=(tags_string)
    #split the tags_string into an array
    #with leading and trailing whitespace removed
    #ensure the string is unique
    #downcase ensures Ruby or ruby will not show up as different tags
    #unique will eliminate duplicate items
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    #look for a tag object with tag_name name
    #if there isn't one create it
    #add the tag object to a list of tags for the article
    new_or_found_tags = tag_names.collect{ |name| Tag.find_or_create_by(name: name)}
    #set the article's tags to the list of tags that have been found
    self.tags = new_or_found_tags
  end
end
