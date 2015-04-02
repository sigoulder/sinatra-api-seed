# encoding: UTF-8
#############################
# models/user.rb
#############################
module MyApp
  class User < ActiveRecord::Base
    validates :email, presence: true, uniqueness: { case_sensitive: false }
  end
end
