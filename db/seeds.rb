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
    password_confirmation: "123",
    name: "Christian",
    description: "I have so many things that I have never used before, it would be really cool to be able to share it with someone that needs them.",
    avatar: File.open(File.join(Rails.root, '/public/images/christian.jpg')),
    facebook: "cvetter34",
    mobile_number: "+852 5374 3892"
  },
  {
    email: "marco@gmail.com",
    password: "123",
    password_confirmation: "123",
    name: "Marco",
    description: "My hobby is outdoor camping, and I keep almost all equipment that could make outdoor camping a much more fun endeavor. Talk to me if you want equipment for your next outdoor camping.",
    avatar: File.open(File.join(Rails.root, '/public/images/marco.jpg')),
    facebook: "marco",
    mobile_number: "+852 5374 3892"
  },
  {
    email: "julie@gmail.com",
    password: "123",
    password_confirmation: "123",
    name: "Julie",
    description: "It's always fun to have BBQ party in your own premise. Me and my family have a BBQ party only once per month and if anyone else would like to use the equipment, ping me.",
    avatar: File.open(File.join(Rails.root, '/public/images/julie.jpg')),
    facebook: "jstag",
    mobile_number: "+852 5374 3892"
  }
])

Tool.create ([
  {
    name: "Shield [Captain America]",
    category: "Tools & Garden",
    description: "The primary defensive and offensive piece of equipment used by the Marvel Comics superhero Captain America; he is seldom seen without it.",
    avatar: File.open(File.join(Rails.root, '/public/images/shield.jpg')),
    user_id: 1
  },
  {
    name: "Hammer [Thor]",
    category: "Tools & Garden",
    description: "The original of the live-action interpretation of Thor's iconic mjolnir as seen in The Avengers.",
    avatar: File.open(File.join(Rails.root, '/public/images/hammer.jpg')),
    user_id: 2
  },
  {
    name: "Bow [Hawkeye]",
    category: "Sporting Equipment",
    description: "Used by Agent Clint Barton as Hawkeye in The Avengers. It has an attachable quiver of five arrows and uses a fast-retracting bowstring.",
    avatar: File.open(File.join(Rails.root, '/public/images/bow.jpg')),
    user_id: 3
  },
  {
    name: "Armor [Iron Man]",
    category: "Sporting Equipment",
    description: "The weapons systems of the suit have changed over the years, but Iron Man's standard offensive weapons have always been the repulsor rays that are fired from the palms of his gauntlets",
    avatar: File.open(File.join(Rails.root, '/public/images/armor.jpeg')),
    user_id: 1
  },
  {
    name: "Web Shooters [Spiderman]",
    category: "Sporting Equipment",
    description: "The wrist-mounted devices fire an adhesive webbing through a threaded adjustable nozzle.",
    avatar: File.open(File.join(Rails.root, '/public/images/web-shooter.jpg')),
    user_id: 2
  },
  {
    name: "Lego",
    category: "Weapon of Mass Destruction",
    description: "Land mine.",
    avatar: File.open(File.join(Rails.root, '/public/images/lego-brick.jpg')),
    user_id: 2
  },
  {
    name: "Ring of Power",
    category: "Tools & Garden",
    description: "One Ring to rule them all.",
    avatar: File.open(File.join(Rails.root, '/public/images/power-ring.jpg')),
    user_id: 3
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