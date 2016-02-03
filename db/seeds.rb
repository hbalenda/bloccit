# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

posts = Post.all

100.times do
  Comment.create!(

  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

puts "#{Post.count} posts created"
uniq_post = Post.find_or_create_by(
    title: "Real Cool Stuff",
    body: "There's a starman waiting in the sky, he'd like to come and meet us but he thinks he'd blow our minds"
    )
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"

uniq_comment = Comment.find_or_create_by(
  post: uniq_post,
  body: "What a cool thing to say!"
)
puts "#{Comment.count} comments created"
puts "Seed finished"
