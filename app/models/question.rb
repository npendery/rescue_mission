class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user

  validates :title, presence: true, length: { minimum: 40,
    too_short: "%{count} characters is the minimum allowed for the title"}
  validates :description, presence: true, length: { minimum: 150,
    too_short: "%{count} characters is the minimum allowed for the description"}
end
