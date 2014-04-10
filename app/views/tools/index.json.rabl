collection @tools, root: :tools

attributes :id, :name, :category, :description, :user_id

node :href do |tool|
  tool_url(tool)
end