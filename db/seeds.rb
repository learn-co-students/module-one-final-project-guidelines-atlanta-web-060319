require_relative "../config/environment"

User.destroy_all
Order.destroy_all
Sandwich.destroy_all

dv = Sandwich.create(name: "Darth Vader", meat: "Turkey", cheese: "American")
ls = Sandwich.create(name: "Luke Skywalker", meat: "Turkey", cheese: "Cheddar")
owk = Sandwich.create(name: "Obi-Wan Kenobi", meat: "Turkey", cheese: "Provolone")
pl = Sandwich.create(name: "Princess Leia", meat: "Tuna Salad", cheese: "American")
hs = Sandwich.create(name: "Han Solo", meat: "Tuna Salad", cheese: "Cheddar")
c3 = Sandwich.create(name: "C-3PO", meat: "Tuna Salad", cheese: "Provolone")
r2 = Sandwich.create(name: "R2-D2", meat: "Ham", cheese: "American")
yo = Sandwich.create(name: "Yoda", meat: "Ham", cheese: "Cheddar")
jh = Sandwich.create(name: "Jabba the Hutt", meat: "Ham", cheese: "Provolone")

robert = User.create(user_name: "Robert Chen", email: "somewhere@something.com")
reina = User.create(user_name: "Reina Ewing", email: "nowhere@someotherthing.com")

order1 = Order.create(user_id: robert.id, sandwich_id: dv.id, bread: "sourdough", green: "spinach", condiment: "mustard", recipe: "dv sourdough spinach mustard")
order2 = Order.create(user_id: reina.id, sandwich_id: ls.id, bread: "sourdough", green: "spinach", condiment: "mustard", recipe: "ls sourdough spinach mustard")
order3 = Order.create(user_id: robert.id, sandwich_id: dv.id, bread: "sourdough", green: "spinach", condiment: "mustard", recipe: "dv sourdough spinach mustard")
order4 = Order.create(user_id: robert.id, sandwich_id: dv.id, bread: "sourdough", green: "spinach", condiment: "mustard", recipe: "dv sourdough spinach mustard")
order5 = Order.create(user_id: robert.id, sandwich_id: dv.id, bread: "sourdough", green: "spinach", condiment: "mustard", recipe: "dv sourdough spinach mustard")
order6 = Order.create(user_id: robert.id, sandwich_id: yo.id, bread: "sourdough", green: "spinach", condiment: "mustard", recipe: "dv sourdough spinach mustard")
order1 = Order.create(user_id: robert.id, sandwich_id: yo.id, bread: "sourdough", green: "spinach", condiment: "mustard", recipe: "dv sourdough spinach mustard")