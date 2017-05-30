class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  mount_uploader :background_image, BackgroundUploader
  
  has_many :comments, :dependent => :destroy
  has_many :identities
  has_many :pages
  has_many :categories
  has_many :marketer_subscribers,foreign_key: "marketer_id",class_name: 'User'
  
  has_many :voteing,foreign_key: "user_id",class_name: 'Rate',dependent:   :destroy
  has_many :votes,foreign_key: "exposition_id",class_name: 'Rate',dependent:   :destroy
  
  has_many :products, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :passive_favorites, class_name:  "Favorite",
             foreign_key: "user_id",
             dependent:   :destroy
  has_many :favorite_produts, through: :passive_favorites,  source: :product
  
  has_many :active_relationships,  class_name:  "Relationship",
             foreign_key: "follower_id",
             dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
             foreign_key: "followed_id",
             dependent:   :destroy
  
    has_many :following, through: :active_relationships,  source: :followed
    has_many :followers, through: :passive_relationships, source: :follower


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:omniauthable
  before_save :ensure_authentication_token    

  scope :marketers, lambda { where(:level => 2) }
  scope :sellers, lambda { where(:level => 1) }




  





  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end

  def instagram
    identities.where( :provider => "instagram" ).first
  end

  def instagram_client
    @instagram_client ||= Instagram.client( access_token: instagram.accesstoken )
  end

  def google_oauth2
    identities.where( :provider => "google_oauth2" ).first
  end

  def google_oauth2_client
    if !@google_oauth2_client
      @google_oauth2_client = Google::APIClient.new(:application_name => 'HappySeed App', :application_version => "1.0.0" )
      @google_oauth2_client.authorization.update_token!({:access_token => google_oauth2.accesstoken, :refresh_token => google_oauth2.refreshtoken})
    end
    @google_oauth2_client
  end
  
  
  
  

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
  
  
  
end
