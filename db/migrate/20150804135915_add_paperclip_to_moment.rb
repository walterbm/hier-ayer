class AddPaperclipToMoment < ActiveRecord::Migration
  def change
    add_attachment :moments, :image  
  end
end
