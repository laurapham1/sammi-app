class ClassMembership < ApplicationRecord
    belongs_to :user
    belongs_to :subject
    validates :user, presence: true
    validates :subject, presence: true
  end
  