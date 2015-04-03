# encoding: UTF-8
#############################
# representers/user_representer.rb
#############################
require 'roar/json'

module UserRepresenter
  include Roar::JSON

  property :id,         writeable: false
  property :created_at, writeable: false
  property :updated_at, writeable: false

  property :email
  property :password, readable: false
end
