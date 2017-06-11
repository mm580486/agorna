class FormUser < User
  attr_accessor :current_password
    attr_accessor :phone
  attr_accessor :login

  validates_presence_of   :email, if: :email_required?
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise.password_length, allow_blank: true
def self.find_for_database_authentication warden_conditions
  conditions = warden_conditions.dup
  login = conditions.delete(:login)
  where(conditions).where(["lower(phone) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
end

  def password_required?
    return false if email.blank?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end
end