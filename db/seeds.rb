# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
  User.create!(
  name: RandomData.random_name,
  email: RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all

#Create Topics
15.times do
  Topic.create!(
  name: RandomData.random_sentence,
  description: RandomData.random_paragraph
  )
end

topics = Topic.all


50.times do
  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

post.update_attribute(:created_at, rand:(10.minutes .. 1.year).ago)
rand(1..5).times {post.votes.create!(value:[-1,1].sample, user: users.sample) }
posts = Post.all

100.times do
  Comment.create!(
  user: users.sample,
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

admin = User.create!(
name: 'Admin User',
email: 'admin@example.com',
password: 'helloworld',
role: 'admin'
)

member = User.create!(
name: 'Member User',
email: 'member@example.com',
password: 'helloworld'
)

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Topic.count} topics created"
puts "#{Comment.count} comments created"
puts "#{User.count} users created"
puts "#{Vote.count} votes created"
