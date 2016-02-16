require 'rails_helper'

RSpec.describe Post, type: :model do
  #creates new instance of post class for test, names it post.
let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)}

it { is_expected.to have_many(:labelings) }
it { is_expected.to have_many(:labels).through(:labelings) }
it { is_expected.to belong_to(:topic) }
it { is_expected.to belong_to(:user) }
it { is_expected.to validate_presence_of(:title) }
it { is_expected.to validate_presence_of(:body) }
it { is_expected.to validate_presence_of(:topic) }
it { is_expected.to validate_presence_of(:user) }
it { is_expected.to validate_length_of(:title).is_at_least(5) }
it { is_expected.to validate_length_of(:body).is_at_least(20) }
it { is_expected.to have_many(:comments) }

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
