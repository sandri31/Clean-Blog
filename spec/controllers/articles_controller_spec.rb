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
end
