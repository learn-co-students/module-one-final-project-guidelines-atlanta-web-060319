User.destroy_all
Restaurant.destroy_all
Review.destroy_all

lumbrzach = User.create(name: "lumbrzach", age:31)
hamallday = User.create(name: "Hamallday", age:32)
king = User.create(name: "king_of_cons", age:37)
parkercita = User.create(name: "parkercita", age:33)
sjp = User.create(name: "sjp", age:21)

###################################################

vecino = Restaurant.create(
    name: "Tacqueria El Vecino", 
    neighborhood: "Oak Grove", 
    salsa_variety?: true
    )
superica_krog = Restaurant.create(
    name: "Superica", 
    neighborhood: "Inman Park", 
    salsa_variety?: true
    )
eduardos = Restaurant.create(
    name: "Eduardos", 
    neighborhood: "Northlake", 
    salsa_variety?: false
    )
mezcalitos = Restaurant.create(
    name: "Mezcalitos", 
    neighborhood: "Grant Park", 
    salsa_variety?: true
    )
barrio = Restaurant.create(
    name: "Mi Barrio", 
    neighborhood: "Grant Park", 
    salsa_variety?: false
    )
taco_mac = Restaurant.create(
    name: "Taco Mac", 
    neighborhood: "Midtown", 
    salsa_variety?: false
    )

#####################################################

review_1 = Review.create(
    user_id: lumbrzach.id, 
    restaurant_id: vecino.id, 
    content: "Tacqueria El Vecino, or 'Vecino' for short, is one of the best places to eat for the chips and salsa lover in the Atlanta area (especially if you find yourself nearby). First and foremost, they have a salsa bar. That's right. Salsa BAR. They have approximaltey 6 staple salsas that cover a wide spectrum of flavors, and always have a 'salsa of the day' too. If this wasn't good enough, their chips are pretty solid too. Good firmness for dipping, crisp enough for that satisfying and not tooth-breaking crunch, and you get both corn and flour chips.",
    rating: 5
    )

review_2 = Review.create(
    user_id: lumbrzach.id, 
    restaurant_id: taco_mac.id, 
    content: "While it is not necesarily a top destination for chips and salsa, Taco Mac does have the pairing on the menu. The chips are on the breakable and greasy side, and they provide a basic red salsa that is pretty basic.  Nothing memorable, but not a bad choice if the craving hits you and you are locked into eating at a Taco Mac.",
    rating: 2
    )

review_3 = Review.create(
    user_id: parkercita.id, 
    restaurant_id: vecino.id, 
    content: "Vecino is the best! They have a salsa bar that keeps my salsa-loving husband plenty busy and lets me have my own salsa that's at a temprature that I actually like (which is differnet from my husband's). The chips are good too!",
    rating: 5
    )

review_4 = Review.create(
    user_id: sjp.id, 
    restaurant_id: mezcalitos.id, 
    content: "While the margaritas here take the show, the chips and salsa are none too shabby either. The chips find a nice balance between stiff and flaky, maybe erring slightly on the stiff side.  They have a red and a green salsa that are both excellent, but the green is hard to get away from. Worth the visit!",
    rating: 4
    )
review_5 = Review.create(
    user_id: sjp.id, 
    restaurant_id: barrio.id, 
    content: "Chips and salsa are actually average, but the atmoshpere is awesoeme!",
    rating: 2
    )