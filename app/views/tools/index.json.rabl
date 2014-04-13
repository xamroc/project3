collection @tools, root: :tools

attributes :id, :name, :category, :description, :user_id, :tool_id, :availability

node :href do |tool|
  tool_url(tool)
end