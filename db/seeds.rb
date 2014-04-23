# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Tool.destroy_all
Transaction.destroy_all

User.create ([
  {
    email: "cvetter34@gmail.com",
    password: "123",
    password_confirmation: "123"
  },
  {
    email: "marco@gmail.com",
    password: "123",
    password_confirmation: "123"
  },
  {
    email: "julie@gmail.com",
    password: "123",
    password_confirmation: "123"
  }
])

Tool.create ([
  {
    name: "Hammer",
    category: "Tools & Garden",
    description: "It fell from Asgard.",
    user_id: 1,
    photos: "",
  },
  {
    name: "Shovel",
    category: "Tools & Garden",
    description: "This is used for digging out corpses.",
    user_id: 2,
    photos: "",
  },
  {
    name: "Ball",
    category: "Sporting Equipment",
    description: "Target: Julie.",
    user_id: 3,
    photos: "",
  }
])

Transaction.create ([
  {
    user_id: 1,
    tool_id: 1
  },
    {
    user_id: 2,
    tool_id: 2
  },
    {
    user_id: 3,
    tool_id: 3
  }
])