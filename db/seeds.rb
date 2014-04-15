# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Tool.destroy_all

User.create ([
  {
    email: "cvetter34@gmail.com",
    password: "123",
    password_confirmation: "123"
  }
])

Tool.create ([
  {
    name: "Hammer",
    category: "Tools & Garden",
    description: "It fell from Asgard.",
    photos: "",
  },
  {
    name: "Shovel",
    category: "Tools & Garden",
    description: "This is used for digging out corpses.",
    photos: "",
  },
  {
    name: "Ball",
    category: "Sporting Equipment",
    description: "Target: Julie.",
    photos: "",
  }
])