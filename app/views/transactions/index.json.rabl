object false

child @transactions, object_root: false do
  attributes :id, :transaction_date, :rent_date, :return_date, :tool_id, :user_id

  node :href do |transaction|
    transaction_url(transaction)
  end

  node :links do |transaction|
    {
      user: user_url(transaction.user),
      tool: tool_url(transaction.tool)
    }
  end

end