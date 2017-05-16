class Post < ApplicationRecord
  belongs_to :user
  acts_as_votable
  acts_as_taggable
  validates_presence_of :title, :url
end
