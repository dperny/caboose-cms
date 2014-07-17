class Caboose::Photo < ActiveRecord::Base
  has_attached_file :image,
    path: 'uploads/:id_:style.:extension',
    styles: {
      tiny: '160x120>',
      thumb: '400x300>',
      large: '640x480>'
    }
  do_not_validate_attachment_file_type :image

  attr_accessible :id,
    :image,
    :title

  validates_attachment :image, presence: true
  validates :name, presence: true
  
end
