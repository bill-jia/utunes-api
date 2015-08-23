class Track < ActiveRecord::Base
  belongs_to :album, counter_cache: true
  has_and_belongs_to_many :artists, counter_cache: true
  accepts_nested_attributes_for :artists, allow_destroy: true

end
