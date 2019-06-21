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

robert = User.create(user_name: "Robert Chen", email: "robertfromsms@gmail.com")
reina = User.create(user_name: "Reina Ewing", email: "reina.castro3@gmail.com")