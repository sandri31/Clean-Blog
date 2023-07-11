# frozen_string_literal: true

class Subscriber < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
