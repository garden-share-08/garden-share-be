Listing.destroy_all
User.destroy_all
Produce.destroy_all

apples = Produce.create(name: "Apples", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
apricots = Produce.create(name: "Apricots", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
asparagus = Produce.create(name: "Asparagus", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
beans = Produce.create(name: "Beans", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
broccoli = Produce.create(name: "Broccoli", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
cabbage = Produce.create(name: "Cabbage", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
carrots = Produce.create(name: "Carrots", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
cauliflower = Produce.create(name: "Cauliflower", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
celery = Produce.create(name: "Celery", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
corn = Produce.create(name: "Corn", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
kale = Produce.create(name: "Kale", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
lettuce = Produce.create(name: "Lettuce", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHJHhdL0TVNv3A46tk4TNrxqqrxCt9m2hVLQ&usqp=CAU")
onions = Produce.create(name: "Onions", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDFoAm8AElesh7Fre14iJoubtJXnp6FAKHUw&usqp=CAU")
peaches = Produce.create(name: "Peaches", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
peas = Produce.create(name: "Peas", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
peppers = Produce.create(name: "Peppers", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
potatoes = Produce.create(name: "Potatoes", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
rhubarb = Produce.create(name: "Rhubarb", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
radishes = Produce.create(name: "Radishes", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
squash = Produce.create(name: "Squash", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
strawberries = Produce.create(name: "Strawberries", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRghzY4e_aeUXpj-RkBWxDSSuPgWw-21Ibcow&usqp=CAU")
tomatoes = Produce.create(name: "Tomatoes", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9pYNcT2ggDPURhdzmZsZdM8p5u3Wc_uxkHg&usqp=CAU")

5.times do 
    first = Faker::Name.first_name
    last = Faker::Name.last_name
  User.create({
    first_name: first,
    last_name: last,
    email: Faker::Internet.email(name: "#{first} #{last}", separators: '.')
  })
end

user1, user2, user3, user4, user5 = User.all

Listing.create({
  user_id: user1.id,
  zip_code: 80219,
  produce_name: squash.name,
  produce_type: 'Zucchini',
  description: 'All organic. No pesticides or herbicides used.',
  quantity: 2,
  unit: 'pounds',
  date_harvested: DateTime.now(),
  status: 'pending'
})
Listing.create({
  user_id: user2.id,
  zip_code: 80208,
  produce_name: peaches.name,
  produce_type: 'Palisade Peaches',
  description: 'These are just peach perfect.',
  quantity: 4,
  unit: 'cartons',
  date_harvested: DateTime.now(),
  status: 'pending'
})
Listing.create({
  user_id: user3.id,
  zip_code: 80205,
  produce_name: corn.name,
  produce_type: 'Sweet',
  description: 'Best excuse to floss you can find.',
  quantity: 10,
  unit: 'ears',
  date_harvested: DateTime.now(),
  status: 'pending'
})
Listing.create({
  user_id: user4.id,
  zip_code: 80229,
  produce_name: rhubarb.name,
  produce_type: 'Rhubarb',
  description: 'Perfect for rhubarb pies.',
  quantity: 3,
  unit: 'bundles',
  date_harvested: DateTime.now(),
  status: 'pending'
})
Listing.create({
  user_id: user5.id,
  zip_code: 80231,
  produce_name: peppers.name,
  produce_type: 'Red, yellow, and green',
  description: 'I\'ve got too many to know what to do with.',
  quantity: 20,
  unit: 'peppers',
  date_harvested: DateTime.now(),
  status: 'pending'
})
