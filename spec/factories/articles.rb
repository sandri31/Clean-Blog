# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'Test Article' }
    body { "This is a valid body with more than five characters." }
    association :user
  end
end
