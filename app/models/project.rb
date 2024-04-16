class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  
  has_many :bugs, dependent: :destroy
  belongs_to :user
end
