require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:new_question) {Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: RandomData.random_boolean)}

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns [new_question] to @questions" do
        get :index
        expect(assigns(:questions)).to eq([new_question])
      end
    end


    describe "GET show" do
      it "returns http success" do
        get :show, {id: new_question.id}
        expect(response).to have_http_status(:success)
       end
      it "renders show view" do
        get :show, {id: new_question.id}
        expect(response).to render_template(:show)
      end

      it "assigns new_question to @question" do
        get :show, {id: new_question.id}
        expect(assigns(:question)).to eq(new_question)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "POST create" do

      it "increases question count by 1" do
        expect{post :create, question:{title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: RandomData.random_boolean}}.to change(Question,:count).by 1
      end

      it "assigns new question to @question" do
        post :create, question:{title:RandomData.random_sentence, body:RandomData.random_paragraph, resolved: RandomData.random_boolean}
        expect(assigns(:question)).to eq Question.last
      end

      it "redirects to the new question" do
        post :create, question:{title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: RandomData.random_boolean}
        expect(response).to redirect_to Question.last
      end

    end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: new_question.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: new_question.id}
      expect(response).to render_template(:edit)
    end

    it "assigns question to update to @question" do
      get :edit, {id: new_question.id}
      question_instance = assigns(:question)
      expect(question_instance.id).to eq new_question.id
      expect(question_instance.title).to eq new_question.title
      expect(question_instance.body).to eq new_question.body
      expect(question_instance.resolved).to eq new_question.resolved
    end
  end

  describe "PUT update" do
    it "updates question with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_boolean = RandomData.random_boolean
      put :update, id: new_question.id, question: {title: new_title, body: new_body, resolved: new_boolean}

      updated_question = assigns(:question)
      expect(updated_question.id).to eq new_question.id
      expect(updated_question.title).to eq new_title
      expect(updated_question.body).to eq new_body
      expect(updated_question.resolved).to eq new_boolean
    end

    it "redirects to the updated question" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_boolean = RandomData.random_boolean

      put :update, id: new_question.id, question: {title: new_title, body: new_body, resolved: new_boolean}
      expect(response).to redirect_to new_question
    end
  end

  describe "DELETE destroy" do
    it "deletes the question" do
      delete :destroy, {id: new_question.id}

      count = Question.where({id: new_question.id}).size
      expect(count).to eq 0
    end

    it "redirects to index" do
      delete :destroy, {id: new_question.id}
      expect(response).to redirect_to questions_path
    end
  end
end
