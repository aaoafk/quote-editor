class Quote < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }
end
