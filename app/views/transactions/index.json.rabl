collection @transactions, root: :transactions

attributes :transaction_date, :rent_date, :return_date, :tool_id, :user_id

node :href do |transaction|
  transaction_url(transaction)
end