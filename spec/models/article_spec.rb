# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'is valid with valid attributes' do
    user = FactoryBot.create(:user)
    article = user.articles.create(
      title: 'Test article',
      body: 'This is a test article for Rspec.'
    )
    expect(article).to be_valid
  end

  it 'is not valid without a title' do
    article = Article.new(title: nil)
    expect(article).to_not be_valid
  end

  it 'is not valid without a body' do
    article = Article.new(body: nil)
    expect(article).to_not be_valid
  end

  it 'is not valid without a user' do
    article = Article.new(user_id: nil)
    expect(article).to_not be_valid
  end

  it 'is deleted when the associated user is deleted' do
    user = FactoryBot.create(:user)
    user.articles.create(
      title: 'Test article',
      body: 'This is a test article for Rspec.'
    )

    expect { user.destroy }.to change { Article.count }.by(-1)
  end

  describe '.filter_by_title' do
    let!(:article1) { create(:article, title: 'Test Article 1') }
    let!(:article2) { create(:article, title: 'Another Article') }

    it 'returns articles that match the title query' do
      expect(Article.filter_by_title('Test')).to include(article1)
      expect(Article.filter_by_title('Test')).not_to include(article2)
    end
  end
end
