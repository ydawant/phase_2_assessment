class User < ActiveRecord::Base
 include BCrypt
 attr_accessor :new_password
 has_many :events
 has_many :event_attendances
 has_many :events, :through => :event_attendances

 validates :email, :format => { :with => /.*@.*.*/, :message => "Email is not valid" }
 validates :email, :uniqueness => true
 validates :email, :password, :presence => true

 def password
    @password ||= Password.new(self.password_hash)
  end
  
  def password=(new_password)
    if new_password.length > 5
      @password = Password.create(new_password)
      self.password_hash = @password
    else
      @password = ''
    end
  end

  def self.create(params = {})
    @user = User.new(:first_name => params[:first_name],
                     :last_name => params[:last_name],
                     :email => params[:email],
                     :birthdate => params[:birthdate])
    @user.password = params[:password]
    @user.save
    @user
  end

  def self.authenticate(params)
    @user = User.find_by_first_name(params[:first_name])
    (@user && @user.password == params[:password]) ? @user : false
  end

  def created_events
    Event.find_all_by_user_id(self.id)
  end

  def attended_events
    EventAttendance.find_all_by_user_id(self.id)
  end


end
