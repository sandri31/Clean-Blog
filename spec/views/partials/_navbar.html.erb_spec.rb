# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'partials/_navbar', type: :view do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user, admin: true) }

  it 'displays the correct links for non-logged in users' do
    render
    expect(rendered).to match(/Accueil/)
    expect(rendered).to match(/A propos/)
    expect(rendered).to match(/Dernier article/)
    expect(rendered).to match(/Contact/)
    expect(rendered).not_to match(/Nouvel article/)
    expect(rendered).not_to match(/Se déconnecter/)
  end

  it 'displays the correct links for logged in users' do
    sign_in user
    render
    expect(rendered).to match(/Accueil/)
    expect(rendered).to match(/A propos/)
    expect(rendered).to match(/Dernier article/)
    expect(rendered).to match(/Contact/)
    expect(rendered).to match(/Nouvel article/)
    expect(rendered).to match(/Se déconnecter/)
  end
end
