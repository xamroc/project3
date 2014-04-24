object false

child @tools, object_root: false do

  attributes :id, :name, :category, :description, :avatar, :user_id, :tool_id, :availability

  if @transactions
    child @transactions, object_root: false do
      attributes :id, :transaction_date, :rent_date
    end
  end

  node :href do |tool|
    tool_url(tool)
    edit_url(tool)
  end

  node :links do |tool|
    {
      user: tool.owner,
      transactions: @transactions ? @transactions.map {|t| t.id} : tool_transactions_url(tool)
    }
  end

end