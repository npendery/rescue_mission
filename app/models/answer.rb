class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :description, presence: true, length: { minimum: 50,
    too_short: "%{count} characters is the minimum allowed for the description"}
  validates :question_id, presence: true
end
