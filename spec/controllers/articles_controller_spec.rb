# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all articles to @articles' do
      article = FactoryBot.create(:article)
      get :index
      expect(assigns(:articles)).to eq([article])
    end
  end

  describe 'GET #show' do
    before do
      @article = FactoryBot.create(:article)
    end

    it 'returns a success response' do
      get :show, params: { id: @article.friendly_id }
      expect(response).to be_successful
    end

    it 'assigns the requested article to @article' do
      get :show, params: { id: @article.friendly_id }
      expect(assigns(:article)).to eq(@article)
    end
  end

  let(:valid_attributes) do
    { title: 'Test Article', body: 'This is a test article.' }
  end

  let(:invalid_attributes) do
    { title: nil, body: nil }
  end

  describe 'GET #new' do
    it 'requires login' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST #create' do
    it 'requires login' do
      post :create, params: { article: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #edit' do
    it 'requires login' do
      article = FactoryBot.create(:article)
      get :edit, params: { id: article.friendly_id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'PUT #update' do
    it 'requires login' do
      article = FactoryBot.create(:article)
      put :update, params: { id: article.friendly_id, article: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'requires login' do
      article = FactoryBot.create(:article)
      delete :destroy, params: { id: article.friendly_id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
