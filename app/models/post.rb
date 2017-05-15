class Post < ApplicationRecord
  belongs_to :user
  acts_as_votable
  acts_as_taggable
end
