# frozen_string_literal: true

class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }, dependent: :destroy
  validates_presence_of :title, :description, :thumbnail
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
end
