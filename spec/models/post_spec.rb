require 'rails_helper'

RSpec.describe Post, type: :model do
  #creates new instance of post class for test, names it post.
let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}

it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    #tests if post has attributes named title and body
    it "responds to title" do
      expect(post).to respond_to(:title)
    end

    it "responds to body" do
      expect(post).to respond_to(:body)
    end

  end
end
