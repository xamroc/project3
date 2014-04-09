collection @tools, root: :tools

attributes :id, :name, :category, :description

node :href do |tool|
  tool_url(tool)
end