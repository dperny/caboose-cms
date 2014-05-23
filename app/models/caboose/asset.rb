
class Caboose::Asset < ActiveRecord::Base
  self.table_name = "assets"
  belongs_to :page
  attr_accessible :page_id, :uploaded_by_id, :date_uploaded, :name, :filename, :description, :extension

  # Replaces spaces with underscores and downcases the filename
  #
  # @param str [String] a string to be sanitized
  # @return a string downcased with spaces replaced
  def sanitize_name(str)
    return str.gsub(' ', '_').downcase 
  end
  
  # What does this do
  def assets_with_uri(uri)
    uri[0] = '' if uri.start_with? '/'
    
		page = Page.page_with_uri(File.dirname(uri), false)		
		return false if page.nil?
		
		asset = Asset.where(:page_id => page.id,:filename => File.basename(uri)).first
		return false if asset.nil?
		
		return asset
	end

end
