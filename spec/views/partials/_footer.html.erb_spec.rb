# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'partials/_footer', type: :view do
  it 'displays the correct elements' do
    render

    expect(rendered).to match(%r{https://github.com/sandri31})

    expect(rendered).to match(/fab fa-github/)

    expect(rendered).to match(/Copyright &copy; Clean Blog 2023/)
  end
end
