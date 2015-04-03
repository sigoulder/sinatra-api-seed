require 'factory_girl'

FactoryGirl.define do
  factory :user, class: MyApp::User do
    sequence(:email) { |n| "test#{n}@example.com"}
    password 'foobar'
  end
end
