class Lecture < ActiveRecord::Base
  belongs_to :user
  validates :date, presence: true
  validates :title, presence: true
  validates :place, presence: true
  validates :detail, presence: true
end
