require 'rails_helper'

RSpec.describe Post, type: :model do
  #creates new instance of post class for test, names it post.
  let(:post) { Post.create!(title:"New Post Title", body: "New Post Body") }

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
