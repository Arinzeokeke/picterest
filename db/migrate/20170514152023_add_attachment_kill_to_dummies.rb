class AddAttachmentKillToDummies < ActiveRecord::Migration[5.1]
  def self.up
    change_table :dummies do |t|
      t.attachment :kill
    end
  end

  def self.down
    remove_attachment :dummies, :kill
  end
end
