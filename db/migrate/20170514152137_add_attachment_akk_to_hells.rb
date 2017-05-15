class AddAttachmentAkkToHells < ActiveRecord::Migration[5.1]
  def self.up
    change_table :hells do |t|
      t.attachment :akk
    end
  end

  def self.down
    remove_attachment :hells, :akk
  end
end
