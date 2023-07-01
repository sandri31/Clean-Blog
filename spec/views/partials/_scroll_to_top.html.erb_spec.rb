# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'partials/_scroll_to_top', type: :view do
  it 'renders the scroll to top button' do
    render

    expect(rendered).to match(/<div class="scrolltop-wrap">/)
    expect(rendered).to match(/<a href="#" role="button" aria-label="Scroll to top">/)
    expect(rendered).to match(%r{<svg height="48" viewBox="0 0 48 48" width="48" height="48px" xmlns="http://www.w3.org/2000/svg">})
    expect(rendered).to match(%r{<path id="scrolltop-bg" d="M0 0h48v48h-48z"></path>})
    expect(rendered).to match(%r{<path id="scrolltop-arrow" d="M14.83 30.83l9.17-9.17 9.17 9.17 2.83-2.83-12-12-12 12z"></path>})
  end
end
