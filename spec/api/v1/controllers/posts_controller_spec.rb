require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_topic) { create(:topic) }
  let(:my_post) { create(:post, topic: my_topic, user: my_user) }
  let(:my_comment) { Comment.create!(body: 'Comment Body', post: my_post, user: my_user) }

  context "unauthenticated user" do
    it "PUT update returns http unauthenticated" do
      put :update, topic: my_topic, id: my_post.id, post: {title: "New Title", body: "New Body"}
      expect(response).to have_http_status(401)
    end

    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, id: my_post.id
      expect(response).to have_http_status(401)
    end
    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "GET show returns post comments" do
      get :show, id: my_post.id
      response_hash = JSON.parse response.body
      expect(response_hash['comments']).to_not be_nil
    end
  end

  context "unauthorized user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end
    
    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "GET show returns post comments" do
      get :show, id: my_post.id
      response_hash = JSON.parse response.body
      expect(response_hash['comments']).to_not be_nil
    end

    it "PUT update returns http forbidden" do
      put :update, topic: my_topic, id: my_post.id, post: {title: "New Title", body: "New Body"}
      expect(response).to have_http_status(403)
    end

    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, id: my_post.id
      expect(response).to have_http_status(403)
    end
  end

  context "authenticated and authorized users" do
    before do
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
      @new_post = build(:post)
    end

    describe "PUT update" do
      before { put :update, id: my_post.id, topic: my_topic, post: {title: @new_post.title, body: @new_post.body} }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "updates a post with the correct attributes" do
        updated_post = Post.find(my_post.id)
        expect(response.body).to eq(updated_post.to_json)
      end
    end

    describe "DELETE destroy" do
      before { delete :destroy, id: my_post.id }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "returns the correct json success message" do
        expect(response.body).to eq({"message" => "Post destroyed","status" => 200}.to_json)
      end

      it "deletes my_post" do
        expect{ Post.find(my_post.id) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
