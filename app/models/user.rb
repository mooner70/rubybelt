class User < ActiveRecord::Base
  has_secure_password
  has_many :groups
  has_many :members
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format:{with: EMAIL_REGEX}
  before_save :downcase_fields

  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end
  

  def downcase_fields
    self.email.downcase!
  end

end
