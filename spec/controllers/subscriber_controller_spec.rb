# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new subscriber' do
        expect do
          post :create, params: { subscriber: { email: 'test@example.com' } }
        end.to change(Subscriber, :count).by(1)
      end

      it 'redirects to the new subscriber' do
        post :create, params: { subscriber: { email: 'test@example.com' } }
        expect(response).to redirect_to Subscriber.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new subscriber' do
        expect do
          post :create, params: { subscriber: { email: '' } }
        end.to_not change(Subscriber, :count)
      end

      it 're-renders the new method' do
        post :create, params: { subscriber: { email: '' } }
        expect(response).to render_template :new
      end
    end
  end
end
