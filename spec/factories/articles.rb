# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'Test Article' }
    body { 'This is a test article.' }
    association :user
  end
end
