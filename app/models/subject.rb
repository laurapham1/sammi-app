class Subject < ApplicationRecord
    belongs_to :user
    has_many :class_memberships
    has_many :class_members, through: :class_memberships, source: :user, class_name: 'User'
    validates :name, presence: true
    validates :user, presence: true
  end
  