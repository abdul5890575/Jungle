class User < ActiveRecord::Base
    has_secure_password
    
    validates :Firstname, presence: true
    validates :Lastname, presence: true
    validates :email, presence: true
    validates :email, uniqueness: { case_sensitive: false }
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6 }
    
     
  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip
       @user = User.find_by_email(email)
       if @user && @user.authenticate(password)
         @user
       else
         nil
       end
     end
     
     
end


