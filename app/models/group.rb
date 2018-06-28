class Group < ActiveRecord::Base
  belongs_to :user
  has_many :members
  has_many :users, through: :members
  validates :name, :description, presence: true
  validates :name, length: { minimum: 5 }
  validates :description, length: { minimum: 10 }
end
