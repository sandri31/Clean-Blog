# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    let!(:article1) { create(:article, title: 'Test Article 1') }
    let!(:article2) { create(:article, title: 'Another Article') }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all articles to @articles' do
      get :index
      expect(assigns(:articles)).to match_array([article1, article2])
    end
  end

  describe 'POST #search' do
    let!(:article1) { create(:article, title: 'Test Article 1') }
    let!(:article2) { create(:article, title: 'Another Article') }

    context 'when a search query is given' do
      it 'assigns @articles to articles that match the search query' do
        post :search, params: { title_search: 'Test' }, xhr: true
        expect(assigns(:articles)).to include(article1)
        expect(assigns(:articles)).not_to include(article2)
      end
    end
  end

  describe 'GET #show' do
    let!(:article) { FactoryBot.create(:article) }

    it 'returns a success response' do
      get :show, params: { id: article.friendly_id }
      expect(response).to be_successful
    end

    it 'assigns the requested article to @article' do
      get :show, params: { id: article.friendly_id }
      expect(assigns(:article)).to eq(article)
    end
  end

  describe 'GET #new' do
    it 'requires login' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      { title: 'Test Article', body: 'This is a test article.' }
    end

    it 'requires login' do
      post :create, params: { article: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #edit' do
    let!(:article) { FactoryBot.create(:article) }

    it 'requires login' do
      get :edit, params: { id: article.friendly_id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'PUT #update' do
    let!(:article) { FactoryBot.create(:article) }
    let(:valid_attributes) do
      { title: 'Updated Title', body: 'Updated body.' }
    end

    it 'requires login' do
      put :update, params: { id: article.friendly_id, article: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:article) { FactoryBot.create(:article) }

    it 'requires login' do
      delete :destroy, params: { id: article.friendly_id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
