class Quote < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }
  after_update_commit -> { broadcast_update_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }
  after_destroy_commit -> { broadcast_remove_to "quotes", locals: { quote: self }, target: "quotes" }
end
