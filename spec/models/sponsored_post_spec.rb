require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
let(:topic) {Topic.create!(name: Randomdata.random_sentence, description: Randomdata.random_paragraph)}
let(:sponsored_post) { SponsoredPost.create!(title:RandomData.random_sentence, body: RandomData.random_paragraph)}

it {is_expected.to belong_to(:topic)}
  describe "attributes" do
    it "responds to title" do
      expect(sponsored_post).to respond_to(:title)
    end
    it "responds to body" do
      expect(sponsored_post).to respond_to(:body)
    end
    it "responds to price" do
      expect(sponsored_post).to respond_to(:price)
    end
  end
end
