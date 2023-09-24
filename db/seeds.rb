# frozen_string_literal: true

USERS = [
  { full_name: 'Kashif Mehmood-1', email: 'mehmoodkashif3054+1@gmail.com', password: 'test123', type: 'Admin' },
  { full_name: 'Kashif Mehmood-2', email: 'mehmoodkashif3054+2@gmail.com', password: 'test123', type: 'Admin' },
  { full_name: 'Thakkar Ali-1', email: 'Thakkarali07+11@gmail.com', password: 'test123', type: 'Teacher' },
  { full_name: 'Thakkar Ali-2', email: 'Thakkarali07+12@gmail.com', password: 'test123', type: 'Teacher' }

].freeze
USERS.each do |i|
  User.new(**i).tap do |user|
    user.confirm
    user.save
  end
end
