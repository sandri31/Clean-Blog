# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  it 'is valid with valid attributes' do
    subscriber = Subscriber.new(email: 'test@example.com')
    expect(subscriber).to be_valid
  end

  it 'is not valid without an email' do
    subscriber = Subscriber.new(email: nil)
    expect(subscriber).to_not be_valid
  end

  it 'is not valid with a duplicate email' do
    Subscriber.create!(email: 'test@example.com')
    subscriber = Subscriber.new(email: 'test@example.com')
    expect(subscriber).to_not be_valid
  end
end
