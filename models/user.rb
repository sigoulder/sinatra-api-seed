# encoding: UTF-8
#############################
# models/user.rb
#############################
module MyApp
  class User < ActiveRecord::Base
    has_secure_password

    validates :email, presence: true, uniqueness: { case_sensitive: false }
  end
end
