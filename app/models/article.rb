class Article < ApplicationRecord

  validates :title, presence: true, length: { minimum: 5 , maximum: 100 }
  validates :subtitle, length: { minimum: 5 , maximum: 100 }
  validates :description, presence: true, length: { minimum: 50 }

end
