class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def self.authenticate_with_credentials(email, password)
    downcase_email = email.downcase
    user = User.find_by(email: downcase_email.strip)
    if user 
      if user.authenticate(password)
        user
      else
        nil
      end
    else
      nil
    end
  end
end
