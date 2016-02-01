require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) {Question.create(title:"New Title", body: "Body", resolved: true) }
  let(:answer) { Answer.create(body: "Body", question: question) }

  describe "attributes" do
    it "responds to body" do
    expect(answer).to respond_to(:body)
    end
  end

end
