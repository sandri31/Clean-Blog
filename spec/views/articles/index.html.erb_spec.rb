# frozen_string_literal: true

RSpec.describe 'articles/index', type: :view do
  before do
    @articles = create_list(:article, 2)
    assign(:articles, @articles)
    assign(:pagy, Pagy.new(count: 1))
    render
  end

  it 'displays the blog title and subtitle' do
    expect(rendered).to match(/Clean Blog/)
    expect(rendered).to match(/Thème réalisé avec Bootstrap/)
  end

  it 'displays each article with its title, subtitle, posted by and created at' do
    @articles.each do |article|
      expect(rendered).to match(/#{article.title}/)
      expect(rendered).to match(/#{article.subtitle}/)
      expect(rendered).to match(/Posté par/)
      expect(rendered).to match(/#{article.user.username}/)
      expect(rendered).to match(/#{article.created_at.strftime("%d/%m/%Y")}/)
    end
  end

  it 'links to the correct article path' do
    @articles.each do |article|
      expect(rendered).to match(article_path(article))
    end
  end
end
