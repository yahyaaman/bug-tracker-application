class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum user_type: [:developer, :manager, :qa]
  validates :name, uniqueness: true

  scope :developer_or_qa, -> { where(user_type: [:developer, :qa]) }
  
  has_many :user_projects
  has_many :projects, through: :user_projects
  
  has_many :projects, dependent: :destroy
  has_many :bugs
end
