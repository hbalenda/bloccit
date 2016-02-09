# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create Topics
15.times do
  Topic.create!(
  name: RandomData.random_sentence,
  description: RandomData.random_paragraph
  )
end

topics = Topic.all


50.times do
  Post.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

posts = Post.all

50.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_number
  )
end

100.times do
  Comment.create!(

  post: posts.sample,
  body: RandomData.random_paragraph
  )
end


puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Topic.count} topics created"
puts "#{Comment.count} comments created"
puts "#{SponsoredPost.count} sponsored posts created"
