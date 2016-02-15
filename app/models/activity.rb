class Activity < ActiveRecord::Base
  belongs_to :log, polymorphic: true
  scope :followed, -> following_id {where "log_id in (?)", following_id}
end