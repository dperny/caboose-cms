class Caboose::Media < ActiveRecord::Base
  has_attached_file :file, :path => '/uploads/:id.:extension'
  do_not_validate_attachment_file_type :file

  attr_accessible :id,
    :name
  
end
