class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false
  
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
  def two_factor_auth?
    !self.phone.blank?
  end
  
  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) #random six digital number
  end
  
  def remove_pin!
    self.update_column(:pin, nil) #random six digital number
  end
  
  def send_pin_to_twilio
    account_sid = 'ACf75052bfe8c8f1d255031aa4df37f2e4'
    auth_token = 'c4e14953775ad935f6621c1c8fdd50ea'
    

    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new(account_sid, auth_token)

    msg = "Hi, please input the following pin into the form: #{self.pin}"
    number = "+1#{self.phone}"
    account = client.account
    message = account.sms.messages.create({:from => '+17787650150', :to => number, :body => msg})
  end
  
  def to_param
    self.username
  end
  
  def admin?
    self.role == 'admin'
  end
  
  def moderator?
    self.role == 'moderator'
  end
  
  
end