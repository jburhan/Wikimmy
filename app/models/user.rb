class User < ApplicationRecord
  before_save { self.role ||= :standard }
  has_many :pages, dependent: :destroy
  has_many :collaborators
  has_many :page_collabs, source: 'page', through: :collaborators
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:standard, :premium, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :standard
  end
end
